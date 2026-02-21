import 'package:get/get.dart';
import '../../services/tmdb_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeController extends GetxController {
  final tabIndex = 0.obs;

  void changeTab(int index) {
    tabIndex.value = index;
  }

  final tmdb = TMDBService();
  int currentPage = 1;
  bool hasMore = true;
  final isLoadingMore = false.obs;



  // 👇 TAMBAHKAN INI
  final username = ''.obs;
  final location = ''.obs;

  final trendingMovie = Rxn<Map<String, dynamic>>(); // 👈 SATU FILM
  final recommendedMovies = <Map<String, dynamic>>[].obs;
  final trendingMovies = <Map<String, dynamic>>[].obs;
  final topRatedMovies = <Map<String, dynamic>>[].obs;
  final nowPlayingMovies = <Map<String, dynamic>>[].obs;

  final isLoading = true.obs;
  final genreMap = {
    "Action": 28,
    "Adventure": 12,
    "Drama": 18,
    "Comedy": 35,
    "Crime": 80,
    "Fantasy": 14,
    "Horror": 27,
    "Sci-fi": 878,
  };

  @override
  void onInit() {
    super.onInit();
    initHome();
  }

  Future<void> initHome() async {
    isLoading(true);

    await fetchUserProfile();
    await fetchMoviesBasic();
    await fetchPersonalizedMovies();

    isLoading(false);
  }

  Future<void> fetchMoviesBasic() async {
    final trending = await tmdb.getTrendingMovies();
    final topRated = await tmdb.getTopRatedMovies();
    final nowPlaying = await tmdb.getNowPlayingMovies();

    trendingMovie.value = trending.first;
    trendingMovies.value = trending.cast<Map<String, dynamic>>();
    topRatedMovies.value = topRated.cast<Map<String, dynamic>>();
    nowPlayingMovies.value = nowPlaying.cast<Map<String, dynamic>>();
  }

  Future<void> fetchUserProfile() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    if (doc.exists) {
      final data = doc.data();

      username.value = (data?['name'] ?? '').toString();
      location.value = (data?['city'] ?? '').toString();

      print("USERNAME: ${username.value}");
    }
  }

  Future<void> fetchPersonalizedMovies({int page = 1}) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();

    final userGenres = List<String>.from(doc['genres'] ?? []);

    if (userGenres.isEmpty) return;

    final firstGenre = userGenres.first;
    final genreId = genreMap[firstGenre];

    final movies = await tmdb.getMoviesByGenre(genreId!, page: page);

    if (page == 1) {
      recommendedMovies.value = movies.cast<Map<String, dynamic>>();
    } else {
      recommendedMovies.addAll(movies.cast<Map<String, dynamic>>());
    }

    if (movies.isEmpty) {
      hasMore = false;
    }
  }

  Future<void> loadMoreRecommended() async {
    if (isLoadingMore.value || !hasMore) return;

    isLoadingMore.value = true;
    currentPage++;

    await fetchPersonalizedMovies(page: currentPage);

    isLoadingMore.value = false;
  }
}
