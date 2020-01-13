import '../models/movie.dart';
import 'movie_provider.dart';

class Repository {
  const Repository(this._movieProvider);

  final MovieProvider _movieProvider;

  Future<List<Movie>> fetchMovies() => _movieProvider.fetchMovies();
}
