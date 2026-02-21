import 'package:get/get.dart';
import '../../services/tmdb_service.dart';

class MovieDetailController extends GetxController {
  final tmdb = TMDBService();

  final int movieId;
  MovieDetailController(this.movieId);

  final movie = Rxn<Map<String, dynamic>>();
  final isLoading = true.obs;

  final trailerKey = RxnString();

  Future<void> fetchTrailer() async {
    try {
      trailerKey.value = await tmdb.getMovieTrailer(movieId);
      print('TRAILER KEY: ${trailerKey.value}');
    } catch (e) {
      print('TRAILER ERROR: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchDetail();
    fetchTrailer(); // 👈
  }

  void fetchDetail() async {
    try {
      isLoading(true);
      movie.value = await tmdb.getMovieDetail(movieId);
    } catch (e) {
      print('DETAIL ERROR: $e');
    } finally {
      isLoading(false);
    }
  }
}
