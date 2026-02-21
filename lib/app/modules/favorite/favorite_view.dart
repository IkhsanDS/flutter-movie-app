import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movieapps/app/modules/favorite/favorite_controller.dart';
import '../../services/tmdb_service.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    final favC = Get.find<FavoriteController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text('My Favorites')),
      body: Obx(() {
        if (favC.favorites.isEmpty) {
          return const Center(
            child: Text(
              'No favorite movies',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          itemCount: favC.favorites.length,
          itemBuilder: (context, i) {
            final movieId = favC.favorites[i];

            return FutureBuilder(
              future: TMDBService().getMovieDetail(movieId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const ListTile(
                    title: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                final movie = snapshot.data as Map<String, dynamic>;

                return ListTile(
                  leading: Image.network(
                    TMDBService.imageBaseUrl + (movie['poster_path'] ?? ''),
                    width: 50,
                    fit: BoxFit.cover,
                  ),
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
          },
        );
      }),
    );
  }
}
