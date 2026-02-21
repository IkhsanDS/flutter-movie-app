import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/home/widgets/shimmer_poster.dart';
import 'home_controller.dart';
import '../../services/tmdb_service.dart';
import '../moviedetail/movie_detail_view.dart';

class RecommendedView extends StatefulWidget {
  const RecommendedView({super.key});

  @override
  State<RecommendedView> createState() => _RecommendedViewState();
}

class _RecommendedViewState extends State<RecommendedView> {
  final controller = Get.find<HomeController>();
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        controller.loadMoreRecommended();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Recommended",
          style: TextStyle(color: Colors.black, fontFamily: 'poppins'),
        ),
      ),
      body: Obx(() {
        return GridView.builder(
          controller: scrollController,
          padding: const EdgeInsets.all(16),
          itemCount:
              controller.recommendedMovies.length +
              (controller.isLoadingMore.value ? 1 : 0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.65,
          ),
          itemBuilder: (context, index) {
            if (index == controller.recommendedMovies.length) {
              return const Center(child: ShimmerPoster());
            }

            final movie = controller.recommendedMovies[index];

            return GestureDetector(
              onTap: () {
                Get.to(() => MovieDetailView(movieId: movie['id']));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 🎬 POSTER
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        TMDBService.imageBaseUrl + (movie['poster_path'] ?? ''),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // 🎥 TITLE
                  Text(
                    movie['title'] ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'poppins',
                    ),
                  ),

                  const SizedBox(height: 4),

                  // ⭐ RATING + 📅 DATE
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        movie['vote_average'].toString(),
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontFamily: 'poppins',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        movie['release_date'] ?? '',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 12,
                          fontFamily: 'poppins',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
