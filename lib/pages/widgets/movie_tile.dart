import 'package:flutter/material.dart';
import '../../models/movie.dart';
import 'color_filtered_movie_card.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key key,
    this.onTap,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final VoidCallback onTap;
  final Movie movie;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: ColorFilteredMovieCard(movie: movie),
      );
}
