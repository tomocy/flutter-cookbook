import 'package:flutter/material.dart';
import '../../models/movie.dart';
import 'overlaid.dart';

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
        child: Overlaid(
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
            ],
          ),
        ),
      );
}
