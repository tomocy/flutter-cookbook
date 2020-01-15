import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../blocs/like_movie_bloc.dart';
import '../../models/movie.dart';

class LikeMovieButton extends StatelessWidget {
  const LikeMovieButton({
    Key key,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) => Consumer<LikeMovieBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Movie>>(
          stream: bloc.movies,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              bloc.notify.add(null);
              return child;
            }

            final isLiked = snapshot.data.contains(movie);
            final color = isLiked
                ? Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).accentColor
                    : Theme.of(context).colorScheme.secondaryVariant
                : Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.onSurface;

            return isLiked
                ? FlatButton.icon(
                    onPressed: () => bloc.cancel.add(movie),
                    label: const Text('Liked'),
                    textColor: color,
                    icon: Icon(
                      Icons.check,
                      color: color,
                    ),
                  )
                : FlatButton.icon(
                    onPressed: () => bloc.like.add(movie),
                    label: const Text('Like'),
                    textColor: color,
                    icon: Icon(
                      Icons.thumb_up,
                      color: color,
                    ),
                  );
          },
        ),
        child: const Icon(Icons.more_horiz),
      );
}
