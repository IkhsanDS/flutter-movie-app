import 'package:flutter/material.dart' hide SearchController;
import 'package:get/get.dart';
import '../../theme/app_colors.dart';
import '../../services/tmdb_service.dart';
import '../moviedetail/movie_detail_view.dart';
import 'search_controller.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          autofocus: true,
          onChanged: controller.onSearch,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: 'Search movies...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.results.isEmpty &&
            controller.query.isNotEmpty) {
          return const Center(
            child: Text(
              'No results found',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.results.length,
          itemBuilder: (context, index) {
            final movie = controller.results[index];
            final posterPath =
                movie['poster_path'] ?? movie['backdrop_path'];

            return ListTile(
              onTap: () {
                Get.to(() => MovieDetailView(
                      movieId: movie['id'],
                    ));
              },
              leading: posterPath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        TMDBService.imageBaseUrl + posterPath,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const SizedBox(width: 50),
              title: Text(
                movie['title'],
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                movie['release_date'] ?? '',
                style: const TextStyle(color: Colors.white54),
              ),
            );
          },
        );
      }),
    );
  }
}
