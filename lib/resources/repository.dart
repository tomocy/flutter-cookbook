import '../models/movie.dart';
import 'movie_provider.dart';

class Repository {
  final _movieProvider = MovieProvider();

  Future<List<Movie>> fetchMovies() => _movieProvider.fetchMovies();
}
