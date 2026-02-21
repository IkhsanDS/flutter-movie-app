import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/favorite/favorite_controller.dart';
import 'package:movieapps/app/modules/home/widgets/shimmer_poster.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../services/tmdb_service.dart';
import '../../theme/app_colors.dart';
import 'movie_detail_controller.dart';

class MovieDetailView extends StatelessWidget {
  final int movieId;
  get favC => Get.find<FavoriteController>();
  const MovieDetailView({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieDetailController(movieId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(() {
        if (controller.isLoading.value || controller.movie.value == null) {
          return const Scaffold(
            backgroundColor: Colors.black,
            body: Center(child: SizedBox(height: 260, child: ShimmerPoster())),
          );
        }
        final movie = controller.movie.value!;
        final posterPath = movie['backdrop_path'] ?? movie['poster_path'];

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 BACKDROP
              Stack(
                children: [
                  SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: Image.network(
                      TMDBService.imageBaseUrl + posterPath,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // 🔥 Gradient biar text kebaca
                  Container(
                    height: 320,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.9),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black54,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 50,
                    right: 16,
                    child: Obx(() {
                      final isFav = favC.isFavorite(movie['id']);
                      return CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: IconButton(
                          icon: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            favC.toggleFavorite(movie);
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'],
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          movie['vote_average'].toString(),
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          movie['release_date'],
                          style: const TextStyle(color: Colors.white54),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    const Text(
                      "Overview",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      movie['overview'],
                      style: const TextStyle(
                        color: Colors.white70,
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 28),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () async {
                          final key = controller.trailerKey.value;
                          if (key == null) return;

                          final url = Uri.parse(
                            'https://www.youtube.com/watch?v=$key',
                          );

                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                        child: const Text(
                          "Watch Trailer",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontFamily: 'Poppins',  
                            color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
