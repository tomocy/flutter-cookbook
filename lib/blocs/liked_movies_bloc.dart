import 'dart:async';
import '../models/movie.dart';

class LikedMoviesBloc {
  LikedMoviesBloc() {
    _isLikedController.stream.listen(_invokeIsLiked);
    _likeController.stream.listen(_invokeLike);
    _cancelController.stream.listen(_invokeCancel);
  }

  final _movies = <Movie>[];
  final _moviesController = StreamController<List<Movie>>();
  final _likedController = StreamController<bool>();
  final _isLikedController = StreamController<Movie>();
  final _likeController = StreamController<Movie>();
  final _cancelController = StreamController<Movie>();

  Stream<List<Movie>> get movies => _moviesController.stream;

  Stream<bool> get liked => _likedController.stream;

  Sink<Movie> get isLiked => _isLikedController.sink;

  Sink<Movie> get like => _likeController.sink;

  Sink<Movie> get cancel => _cancelController.sink;

  void _invokeIsLiked(Movie movie) => _likedController.add(_isLiked(movie));

  void _invokeLike(Movie movie) => _invokeLikeOrCancel(movie, true);

  void _invokeCancel(Movie movie) => _invokeLikeOrCancel(movie, false);

  void _invokeLikeOrCancel(Movie movie, bool like) {
    final wasUpdated = _likeOrCancel(movie, like);
    if (!wasUpdated) {
      return;
    }

    _moviesController.add(_movies);
    _invokeIsLiked(movie);
  }

  bool _likeOrCancel(Movie movie, bool like) {
    if (_isLiked(movie) == like) {
      return false;
    }

    if (like) {
      _movies.add(movie);
    } else {
      _movies.remove(movie);
    }

    return true;
  }

  bool _isLiked(Movie movie) => _movies.contains(movie);

  void dispose() {
    _moviesController.close();
    _likedController.close();
    _isLikedController.close();
    _likeController.close();
    _cancelController.close();
  }
}
