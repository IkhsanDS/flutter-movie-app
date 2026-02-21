import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/favorite/favorite_controller.dart';
import 'package:movieapps/app/modules/home/widgets/shimmer_poster.dart';
import 'package:movieapps/app/modules/moviedetail/movie_detail_view.dart';
import 'package:movieapps/app/services/tmdb_service.dart';

class WatchlistView extends StatelessWidget {
  const WatchlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final favC = Get.find<FavoriteController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('My Watchlist')),
      body: Obx(() {
        if (favC.favorites.isEmpty) {
          return const Center(
            child: Text(
              "No favorite movies",
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.7,
          ),
          itemCount: favC.favorites.length,
          itemBuilder: (context, i) {
            final movieId = favC.favorites[i];

            return FutureBuilder(
              future: TMDBService().getMovieDetail(movieId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const ShimmerPoster();
                }

                final movie = snapshot.data as Map<String, dynamic>;

                return Dismissible(
                  key: ValueKey(movieId),

                  direction: DismissDirection.endToStart,
                  onDismissed: (_) {
                    favC.removeFavorite(movieId);
                  },

                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.redAccent,
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => MovieDetailView(movieId: movieId));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.network(
                                    TMDBService.imageBaseUrl +
                                        (movie['poster_path'] ?? ''),
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // 🔥 Gradient overlay bawah
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 60,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                        colors: [
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          movie['title'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 14,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              movie['vote_average'].toString(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}
