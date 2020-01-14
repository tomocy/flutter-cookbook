import 'package:flutter/material.dart';
import '../../models/movie.dart';

class ColorFilteredMovieCard extends StatelessWidget {
  const ColorFilteredMovieCard({
    Key key,
    @required this.movie,
    this.children = const [],
  })  : assert(movie != null),
        super(key: key);

  final Movie movie;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          Card(
            margin: const EdgeInsets.all(0),
            child: Image.network(
              movie.posterUri,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Colors.white),
                ),
              ]..addAll(children),
            ),
          ),
        ],
      );
}
