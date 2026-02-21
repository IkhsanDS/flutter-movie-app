import 'package:get/get.dart';
import '../../services/tmdb_service.dart';

class SearchController extends GetxController {
  final tmdb = TMDBService();

  final query = ''.obs;
  final results = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  void onSearch(String text) async {
    query.value = text;

    if (text.isEmpty) {
      results.clear();
      return;
    }

    try {
      isLoading(true);
      final res = await tmdb.searchMovies(text);
      results.value = res.cast<Map<String, dynamic>>();
    } catch (e) {
      print('SEARCH ERROR: $e');
    } finally {
      isLoading(false);
    }
  }
}
