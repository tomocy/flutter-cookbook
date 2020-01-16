import 'package:flutter/material.dart';
import '../../models/movie.dart';
import 'movie_tile.dart';

class MoviesGridView extends StatelessWidget {
  const MoviesGridView({
    Key key,
    this.onTapMovie,
    this.movies = const [],
  }) : super(key: key);

  final Function(Movie) onTapMovie;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: movies.length,
        itemBuilder: (_, i) => Padding(
          padding: const EdgeInsets.all(4),
          child: MovieTile(
            onTap: onTapMovie != null ? () => onTapMovie(movies[i]) : null,
            movie: movies[i],
          ),
        ),
      );
}
