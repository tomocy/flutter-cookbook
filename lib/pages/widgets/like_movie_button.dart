import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/liked_movies.dart';
import '../../models/movie.dart';

class LikeMovieButton extends StatelessWidget {
  const LikeMovieButton({
    Key key,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) => Consumer<LikedMovies>(
        builder: (context, liked, _) {
          final isLiked = liked.movies.contains(movie);
          final color = isLiked
              ? Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).accentColor
                  : Theme.of(context).colorScheme.secondaryVariant
              : Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.onSurface;

          return isLiked
              ? FlatButton.icon(
                  onPressed: () =>
                      Provider.of<LikedMovies>(context, listen: false)
                          .cancel(movie),
                  label: const Text('Liked'),
                  textColor: color,
                  icon: Icon(
                    Icons.check,
                    color: color,
                  ),
                )
              : FlatButton.icon(
                  onPressed: () =>
                      Provider.of<LikedMovies>(context, listen: false)
                          .like(movie),
                  label: const Text('Like'),
                  textColor: color,
                  icon: Icon(
                    Icons.thumb_up,
                    color: color,
                  ),
                );
        },
      );
}
