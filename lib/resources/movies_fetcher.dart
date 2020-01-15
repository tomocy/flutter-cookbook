import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import '../blocs/resources/movies_fetcher.dart';
import '../models/movie.dart';

final _tmdbApiKey = '802b2c4b88ea1183e50e6b285a27696e';

Future<List<Movie>> fetchMoviesFromTmdb() async {
  final response = await get(
      'https://api.themoviedb.org/3/discover/movie?api_key=$_tmdbApiKey');
  if (response.statusCode != 200) {
    throw MoviesFetchException();
  }

  final body = json.decode(response.body) as Map<String, dynamic>;
  final jsons = body['results'] as List<dynamic>;

  return jsons
      .map((json) => Movie.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<List<Movie>> fetchMockMovies() async => List<Movie>.generate(
      100,
      (i) => Movie(
        id: i,
        score: 10 * Random().nextDouble(),
        title: 'Movie $i',
        overview: 'Overview of Movie $i',
        posterUri:
            'https://image.tmdb.org/t/p/w1280/AgHqnakBc8O9eGh4rrNPquZmZ4K.jpg',
      ),
    );
