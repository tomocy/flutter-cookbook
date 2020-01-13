import 'dart:convert';
import 'package:http/http.dart';
import '../models/movie.dart';

class MovieProvider {
  const MovieProvider(this._apiKey, this._client);

  final String _apiKey;
  final Client _client;

  Future<List<Movie>> fetchMovies() async {
    final response = await _client
        .get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');

    if (response.statusCode != 200) {
      throw Exception('${response.statusCode}');
    }

    return moviesFromJson(json.decode(response.body) as Map<String, dynamic>);
  }
}
