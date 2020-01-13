import 'dart:convert';
import 'package:http/http.dart';
import '../models/movie.dart';
import '../models/status.dart';

class MovieProvider {
  const MovieProvider(this._apiKey, this._client);

  final String _apiKey;
  final Client _client;

  Future<Status> fetchMovies() async {
    final response = await _client
        .get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');

    if (response.statusCode != 200) {
      return Status<Exception>.failed(
          Exception(response.statusCode.toString()));
    }

    return Status<List<Movie>>.success(
        moviesFromJson(json.decode(response.body) as Map<String, dynamic>));
  }
}
