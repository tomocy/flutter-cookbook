import 'dart:convert';
import 'package:http/http.dart';
import '../models/movie.dart';

class MovieProvider {
  final _client = Client();
  final _apiKey = '802b2c4b88ea1183e50e6b285a27696e';

  Future<List<Movie>> fetchMovies() async {
    final response = await _client
        .get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');

    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}');
    }

    return moviesFromJson(json.decode(response.body) as Map<String, dynamic>);
  }
}
