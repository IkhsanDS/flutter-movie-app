import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/moviedetail/movie_detail_view.dart';
import 'package:movieapps/app/theme/widgets.dart';
// import '../../../theme/app_colors.dart';

class HeroCard extends StatelessWidget {
  final int movieId;
  final String title;
  final String poster;
  final String language;
  final String genre;

  // 👇 INI YANG DISEBUT CONSTRUCTOR
  const HeroCard({
    super.key,
    required this.movieId,
    required this.title,
    required this.poster,
    required this.language,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(poster, fit: BoxFit.cover),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // 🔥 INI WAJIB
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, // 🔥 WAJIB
                          ),
                          const SizedBox(height: 8),
                          Text(
                            language,
                            style: const TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),

                    // Buttons
                    Column(
                      children: [
                        trailerButton(() {
                          Get.to(() => MovieDetailView(movieId: movieId));
                        }),
                        const SizedBox(height: 4),
                      ],
                    ),
                    
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
