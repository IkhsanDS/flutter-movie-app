import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/home/home_controller.dart';
import 'package:movieapps/app/modules/home/widgets/hero_card.dart';
import 'package:movieapps/app/modules/home/widgets/home_header.dart';
import 'package:movieapps/app/modules/home/widgets/movie_carousel.dart';
import 'package:movieapps/app/modules/home/widgets/shimmer_poster.dart';
import 'package:movieapps/app/services/tmdb_service.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.initHome(); // reload semua data
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeHeader(controller: controller),
              const SizedBox(height: 24),

              Obx(() {
                if (controller.isLoading.value ||
                    controller.trendingMovie.value == null) {
                  return const SizedBox(
                    height: 200,
                    child: const ShimmerPoster(),
                  );
                }

                final movie = controller.trendingMovie.value!;
                final posterpath =
                    movie['backdrop_path'] ?? movie['poster_path'];

                return HeroCard(
                  movieId: movie['id'],
                  title: movie['title'],
                  poster: TMDBService.imageBaseUrl + posterpath,
                  language: movie['original_language'].toUpperCase(),
                  genre: 'TRENDING',
                );
              }),

              const SizedBox(height: 32),

              Obx(() {
                if (controller.isLoading.value) {
                  return SizedBox(height: 220, child: const ShimmerPoster());
                }

                return Column(
                  children: [
                    MovieCarousel(
                      title: "Trending",
                      movies: controller.trendingMovies,
                    ),

                    const SizedBox(height: 24),

                    MovieCarousel(
                      title: "Recommended",
                      movies: controller.recommendedMovies,
                    ),

                    const SizedBox(height: 24),

                    MovieCarousel(
                      title: "Top Rated",
                      movies: controller.topRatedMovies,
                    ),

                    const SizedBox(height: 24),

                    MovieCarousel(
                      title: "Now Playing",
                      movies: controller.nowPlayingMovies,
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
