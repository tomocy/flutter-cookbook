import 'dart:async';
import '../models/movie.dart';
import '../models/status.dart';
import '../resources/repository.dart';

class MovieBloc {
  MovieBloc(this._repository) {
    _fetchController.stream.listen((_) => _fetchMovies());
  }

  final Repository _repository;
  final _moviesController = StreamController<List<Movie>>();
  final _fetchController = StreamController<void>();

  Stream<List<Movie>> get movies => _moviesController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Future<void> _fetchMovies() async {
    final status = await _repository.fetchMovies();
    if (status is SuccessStatus<List<Movie>>) {
      _moviesController.add(status.value);
    } else if (status is FailedStatus) {
      _moviesController.addError(status.error);
    }
  }

  Future<void> dispose() async {
    await _moviesController.close();
    await _fetchController.close();
  }
}
