import 'dart:async';
import '../models/movie.dart';
import 'resources/movies_fetcher.dart';

class FetchMoviesBloc {
  FetchMoviesBloc(this._fetch) {
    _fetchController.stream.listen(_invokeFetch);
  }

  final MoviesFetcher _fetch;
  final _moviesController = StreamController<List<Movie>>();
  final _fetchController = StreamController<void>();

  Stream<List<Movie>> get movies => _moviesController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      final movies = await _fetch();
      _moviesController.add(movies);
    } on MoviesFetchException catch (e) {
      _moviesController.addError(e.toString());
    }
  }

  void dispose() {
    _moviesController.close();
    _fetchController.close();
  }
}
