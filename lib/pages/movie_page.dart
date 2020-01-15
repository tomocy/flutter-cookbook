import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'widgets/movie_details_tile.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key key,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(movie.title)),
        body: SafeArea(child: MovieDetailsTile(movie: movie)),
      );
}
