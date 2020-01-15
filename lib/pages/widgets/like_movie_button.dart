import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/liked_movies.dart';
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
  Widget build(BuildContext context) => Consumer<LikedMovies>(
        builder: (context, liked, _) => liked.movies.contains(movie)
            ? IconButton(
                onPressed: () =>
                    Provider.of<LikedMovies>(context, listen: false)
                        .cancel(movie),
                icon: Icon(
                  Icons.check,
                  color: color,
                ),
              )
            : IconButton(
                onPressed: () =>
                    Provider.of<LikedMovies>(context, listen: false)
                        .like(movie),
                icon: Icon(
                  Icons.thumb_up,
                  color: color,
                ),
              ),
      );
}
