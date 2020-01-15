import 'dart:async';
import '../models/movie.dart';
import 'resources/movies_fetcher.dart';

class FetchMoviesBloc {
  FetchMoviesBloc(this._fetch) {
    _fetchController.stream.listen(_invokeFetch);
    _filterController.stream.listen(_invokeFilter);
  }

  final MoviesFetcher _fetch;
  final _movies = <Movie>[];
  final _moviesController = StreamController<List<Movie>>.broadcast();
  final _filteredMoviesController = StreamController<List<Movie>>.broadcast();
  final _fetchController = StreamController<void>();
  final _filterController = StreamController<String>();

  Stream<List<Movie>> get movies => _moviesController.stream;

  Stream<List<Movie>> get filteredMovies => _filteredMoviesController.stream;

  Sink<void> get fetch => _fetchController.sink;

  Sink<String> get filter => _filterController.sink;

  Future<void> _invokeFetch(void _) async {
    try {
      final movies = await _fetch();
      _movies
        ..clear()
        ..addAll(movies);
      _moviesController.add(_movies);
    } on MoviesFetchException catch (e) {
      _moviesController.addError(e.toString());
    }
  }

  void _invokeFilter(String query) => _filteredMoviesController.add(_movies
      .where((movie) => query.isNotEmpty && movie.title.contains(query))
      .toList());

  void dispose() {
    _moviesController.close();
    _filteredMoviesController.close();
    _fetchController.close();
    _filterController.close();
  }
}
