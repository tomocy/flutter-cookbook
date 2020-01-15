import 'package:flutter/material.dart';
import 'movie.dart';

class LikedMovies extends ChangeNotifier {
  final _movies = <Movie>[];

  List<Movie> get movies => _movies;

  void like(Movie movie) {
    if (movies.contains(movie)) {
      return;
    }

    _movies.add(movie);
    notifyListeners();
  }

  void cancel(Movie movie) {
    if (!movies.contains(movie)) {
      return;
    }

    _movies.remove(movie);
    notifyListeners();
  }
}
