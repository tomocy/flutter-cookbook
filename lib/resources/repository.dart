import '../models/status.dart';
import 'movie_provider.dart';

class Repository {
  const Repository(this._movieProvider);

  final MovieProvider _movieProvider;

  Future<Status> fetchMovies() => _movieProvider.fetchMovies();
}
