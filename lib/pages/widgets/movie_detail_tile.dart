import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/liked_movies.dart';
import '../../models/movie.dart';
import 'like_movie_button.dart';
import 'overlaid.dart';

class MovieDetailsTile extends StatelessWidget {
  const MovieDetailsTile({
    Key key,
    this.onThumbUp,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final VoidCallback onThumbUp;
  final Movie movie;

  @override
  Widget build(BuildContext context) => Overlaid(
        background: Image.network(
          movie.posterUri,
          fit: BoxFit.cover,
        ),
        color: Colors.black.withOpacity(0.5),
        foreground: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              movie.title,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.white),
            ),
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
              movie.fixedScore,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            LikeMovieButton(movie: movie),
          ],
        ),
      );
}
