import '../../models/movie.dart';

typedef MoviesFetcher = Future<List<Movie>> Function();

class MoviesFetchException implements Exception {}
