import 'package:dio/dio.dart';
import 'package:moviyee/models/Genre.model.dart';

class GenreService {
  final String apiUrl = 'https://api.themoviedb.org/3/genre/movie/list?language=en&api_key=b426ac0d6d34af117beb43c263b8d2ed';
  final Dio _dio = Dio();

  Future<List<Genre>> fetchGenres() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        final List<dynamic> genresJson = response.data['genres'];
        return genresJson.map((json) => Genre.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      throw Exception('Failed to load genres: $e');
    }
  }

  Future<Map<int, String>> getGenreMap() async {
    final GenreService genreService = GenreService();
    final List<Genre> genres = await genreService.fetchGenres();
    return {for (var genre in genres) genre.id: genre.name};
  }
}