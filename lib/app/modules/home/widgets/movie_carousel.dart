import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/favorite/favorite_controller.dart';
import 'package:movieapps/app/modules/home/recomended_view.dart';
import 'package:movieapps/app/modules/moviedetail/movie_detail_view.dart';
import '../../../services/tmdb_service.dart';

class MovieCarousel extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> movies;

  const MovieCarousel({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              if (title == "Recommended")
                GestureDetector(
                  onTap: () {
                    Get.to(() => const RecommendedView());
                  },
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
        ),

        const SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final movie = movies[index];
              final favC = Get.find<FavoriteController>();

              return GestureDetector(
                onTap: () {
                  Get.to(() => MovieDetailView(movieId: movie['id']));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Image.network(
                        TMDBService.imageBaseUrl + movie['poster_path'],
                        width: 140,
                        height: 220,
                        fit: BoxFit.cover,
                      ),

                      // ❤️ FAVORITE ICON
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Obx(() {
                          final isFav = favC.isFavorite(movie['id']);

                          return GestureDetector(
                            onTap: () {
                              favC.toggleFavorite(movie);
                            },
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: Colors.redAccent,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
