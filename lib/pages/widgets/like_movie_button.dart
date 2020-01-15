import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../blocs/liked_movies_bloc.dart';
import '../../models/movie.dart';

class LikeMovieButton extends StatelessWidget {
  const LikeMovieButton({
    Key key,
    this.color,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final Color color;
  final Movie movie;

  @override
  Widget build(BuildContext context) => StreamBuilder<bool>(
        stream: Provider.of<LikedMoviesBloc>(context).liked,
        initialData: false,
        builder: (_, snapshot) => snapshot.data
            ? IconButton(
                onPressed: () =>
                    Provider.of<LikedMoviesBloc>(context, listen: false)
                        .cancel
                        .add(movie),
                icon: Icon(
                  Icons.check,
                  color: color,
                ),
              )
            : IconButton(
                onPressed: () =>
                    Provider.of<LikedMoviesBloc>(context, listen: false)
                        .like
                        .add(movie),
                icon: Icon(
                  Icons.thumb_up,
                  color: color,
                ),
              ),
      );
}
