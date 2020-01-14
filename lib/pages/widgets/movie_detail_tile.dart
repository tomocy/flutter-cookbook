import 'package:flutter/material.dart';
import '../../models/movie.dart';
import 'color_filtered_movie_card.dart';

class MovieDetailTile extends StatelessWidget {
  const MovieDetailTile({
    Key key,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) => ColorFilteredMovieCard(
        movie: movie,
        children: [
          const SizedBox(height: 5),
          Text(
            movie.overview,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            movie.score.toStringAsFixed(1),
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(color: Colors.white),
          ),
        ],
      );
}
