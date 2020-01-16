import 'dart:async';
import '../models/movie.dart';

class LikeMovieBloc {
  LikeMovieBloc() {
    _likeController.stream.listen(_invokeLike);
    _isLikedController.stream.listen(_invokeIsLiked);
    _cancelController.stream.listen(_invokeCancel);
    _notifyController.stream.listen(_invokeNotify);
  }

  final _movies = <Movie>[];
  final _moviesController = StreamController<List<Movie>>.broadcast();
  final _likedController = StreamController<bool>.broadcast();
  final _isLikedController = StreamController<Movie>();
  final _likeController = StreamController<Movie>();
  final _cancelController = StreamController<Movie>();
  final _notifyController = StreamController<void>();

  Stream<List<Movie>> get movies => _moviesController.stream;

  Stream<bool> get liked => _likedController.stream;

  Sink<Movie> get isLiked => _isLikedController.sink;

  Sink<Movie> get like => _likeController.sink;

  Sink<Movie> get cancel => _cancelController.sink;

  Sink<void> get notify => _notifyController.sink;

  void _invokeIsLiked(Movie movie) => _likedController.add(_isLiked(movie));

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

    _invokeIsLiked(movie);
    _invokeNotify(null);
  }

  bool _isLiked(Movie movie) => _movies.contains(movie);

  void _invokeNotify(void _) => _moviesController.add(_movies);

  void dispose() {
    _moviesController.close();
    _likedController.close();
    _isLikedController.close();
    _likeController.close();
    _cancelController.close();
    _notifyController.close();
  }
}
