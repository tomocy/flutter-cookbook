import 'package:flutter/material.dart';
import '../models/movie.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({
    Key key,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: const BoxConstraints.expand(height: 200),
                child: Image.network(
                  'https://image.tmdb.org/t/p/w185${movie.posterPath}',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                movie.title,
                style: Theme.of(context).textTheme.title,
              ),
            ],
          ),
        ),
      );
}
