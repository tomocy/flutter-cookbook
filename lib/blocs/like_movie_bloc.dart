import 'dart:async';
import '../models/movie.dart';

class LikeMovieBloc {
  LikeMovieBloc() {
    _notifyController.stream.listen(_invokeNotify);
    _likeController.stream.listen(_invokeLike);
    _cancelController.stream.listen(_invokeCancel);
  }

  final _movies = <Movie>[];
  final _moviesController = StreamController<List<Movie>>.broadcast();
  final _notifyController = StreamController<void>();
  final _likeController = StreamController<Movie>();
  final _cancelController = StreamController<Movie>();

  Stream<List<Movie>> get movies => _moviesController.stream;

  Stream<bool> isLiked(Movie movie) =>
      movies.transform<bool>(StreamTransformer.fromHandlers(
        handleData: (movies, sink) => sink.add(movies.contains(movie)),
      ));

  Sink<void> get notify => _notifyController.sink;

  Sink<Movie> get like => _likeController.sink;

  Sink<Movie> get cancel => _cancelController.sink;

  void _invokeLike(Movie movie) => _invokeLikeOrCancel(movie, true);

  void _invokeCancel(Movie movie) => _invokeLikeOrCancel(movie, false);

  void _invokeLikeOrCancel(Movie movie, bool like) {
    if (_isLiked(movie) == like) {
      return;
    }

    if (like) {
      _movies.add(movie);
    } else {
      _movies.remove(movie);
    }

    _invokeNotify(null);
  }

  bool _isLiked(Movie movie) => _movies.contains(movie);

  void _invokeNotify(void _) => _moviesController.add(_movies);

  void dispose() {
    _moviesController.close();
    _notifyController.close();
    _likeController.close();
    _cancelController.close();
  }
}
