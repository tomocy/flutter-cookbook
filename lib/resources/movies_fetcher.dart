import 'dart:math';
import '../models/movie.dart';

Future<List<Movie>> fetchMockMovies() async => List<Movie>.generate(
      100,
      (i) => Movie(
        id: i,
        score: 10 * Random().nextDouble(),
        title: 'Movie $i',
        overview: 'Overview of Movie $i',
        posterUri:
            'https://image.tmdb.org/t/p/w1280/AgHqnakBc8O9eGh4rrNPquZmZ4K.jpg',
      ),
    );
