import 'package:dio/dio.dart';
import 'package:moviyee/models/movie_model.dart';

class RemoteDataSorce {
  final  dio = Dio(BaseOptions(baseUrl: "https://api.themoviedb.org"));


  Future<ModelClass?> fetchTrending(int paraOffset) async {
    try {
      var response = await dio.get(
          '/3/movie/popular?language=en-US&page=$paraOffset&api_key=b426ac0d6d34af117beb43c263b8d2ed');

      ModelClass modelClass = ModelClass.fromJson(response.data);

      return modelClass;
    } catch (e) {
      print("Error: $e");
    }
  }
static Future<List<Result>> fetchMovies(int num, String sectionName) async {
    final dio = Dio();

    try {
      var response = await dio.get(
          'https://api.themoviedb.org/3/movie/$sectionName?language=en-US&page=$num&api_key=b426ac0d6d34af117beb43c263b8d2ed');

      if (response.statusCode == 200) {
        ModelClass modelClass = ModelClass.fromJson(response.data);
        return modelClass.results!;
      } else {
        throw Exception('Failed to load top rated movies');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load top rated movies');
    }
  }


}
