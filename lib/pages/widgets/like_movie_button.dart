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
        builder: (context, liked, _) => liked.movies.contains(movie)
            ? IconButton(
                onPressed: () =>
                    Provider.of<LikedMovies>(context, listen: false)
                        .cancel(movie),
                icon: Icon(
                  Icons.check,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).accentColor
                      : Theme.of(context).colorScheme.secondaryVariant,
                ),
              )
            : IconButton(
                onPressed: () =>
                    Provider.of<LikedMovies>(context, listen: false)
                        .like(movie),
                icon: Icon(
                  Icons.thumb_up,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).colorScheme.surface
                      : Theme.of(context).colorScheme.onSurface,
                ),
              ),
      );
}
