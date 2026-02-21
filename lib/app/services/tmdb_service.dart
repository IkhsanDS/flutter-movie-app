import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TMDBService {
  static String apiKey = dotenv.env['TMDB_API_KEY']!;
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  Future<List<dynamic>> getTrendingMovies() async {
    final res = await http.get(
      Uri.parse('$baseUrl/trending/movie/day?api_key=$apiKey'),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['results'];
    } else {
      throw Exception('TMDB ERROR ${res.statusCode}: ${res.body}');
    }
  }

  Future<List<dynamic>> getPopularMovies() async {
    final res = await http.get(
      Uri.parse('$baseUrl/movie/popular?api_key=$apiKey'),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['results'];
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<Map<String, dynamic>> getMovieDetail(int id) async {
    final res = await http.get(Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'));

    if (res.statusCode == 200) {
      return json.decode(res.body);
    } else {
      throw Exception('Failed to load movie detail');
    }
  }

  Future<String?> getMovieTrailer(int movieId) async {
    final url = '$baseUrl/movie/$movieId/videos?api_key=$apiKey';

    print('TRAILER URL: $url');

    final res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      final results = json.decode(res.body)['results'] as List;

      if (results.isEmpty) return null;

      final trailer = results.firstWhere(
        (v) => v['site'] == 'YouTube' && v['type'] == 'Trailer',
        orElse: () => null,
      );

      return trailer?['key'];
    } else {
      print('TRAILER ERROR ${res.statusCode}: ${res.body}');
      return null;
    }
  }

  Future<List<dynamic>> searchMovies(String query) async {
    if (query.isEmpty) return [];

    final res = await http.get(
      Uri.parse('$baseUrl/search/movie?api_key=$apiKey&query=$query'),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['results'];
    } else {
      throw Exception('Failed to search movies');
    }
  }

  Future<List<dynamic>> getTopRatedMovies() async {
    final res = await http.get(
      Uri.parse('$baseUrl/movie/top_rated?api_key=$apiKey'),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['results'];
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<dynamic>> getNowPlayingMovies() async {
    final res = await http.get(
      Uri.parse('$baseUrl/movie/now_playing?api_key=$apiKey'),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['results'];
    } else {
      throw Exception('Failed to load now playing movies');
    }
  }

  // Future<List<dynamic>> getMoviesByGenre(int genreId) async {
  //   final res = await http.get(
  //     Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId'),
  //   );

  //   if (res.statusCode == 200) {
  //     return json.decode(res.body)['results'];
  //   } else {
  //     throw Exception('Failed to load movies by genre');
  //   }
  // }

  Future<List<dynamic>> getMoviesByGenres(List<int> genreIds) async {
    final ids = genreIds.join(',');

    final response = await http.get(
      Uri.parse('$baseUrl/discover/movie?api_key=$apiKey&with_genres=$ids'),
    );

    final data = json.decode(response.body);
    return data['results'];
  }

  Future<List<dynamic>> getMoviesByGenre(int genreId, {int page = 1}) async {
    final res = await http.get(
      Uri.parse(
        '$baseUrl/discover/movie?api_key=$apiKey&with_genres=$genreId&page=$page',
      ),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['results'];
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<List<dynamic>> getUpcomingMovies({int page = 1}) async {
    final res = await http.get(
      Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey&page=$page'),
    );

    if (res.statusCode == 200) {
      return json.decode(res.body)['results'];
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }
}
