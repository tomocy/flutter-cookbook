import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bloc/movie_bloc.dart';
import '../models/movie.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage._({Key key}) : super(key: key);

  static Widget create(BuildContext context) => Provider<MovieBloc>(
        create: (_) => MovieBloc()..fetch.add(null),
        dispose: (_, bloc) => bloc.dispose(),
        child: const MoviesPage._(),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Movies')),
        body: SafeArea(
          child: Consumer<MovieBloc>(
            builder: (_, bloc, child) => StreamBuilder<List<Movie>>(
              stream: bloc.movies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return MovieList(movies: snapshot.data);
                }
                if (snapshot.hasError) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: Text(snapshot.error.toString()),
                        )));
                }

                return child;
              },
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
}

class MovieList extends StatelessWidget {
  const MovieList({
    Key key,
    @required this.movies,
  })  : assert(movies != null),
        super(key: key);

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) => GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: movies.length,
        itemBuilder: (_, i) => Image.network(
          'https://image.tmdb.org/t/p/w185${movies[i].posterPath}',
          fit: BoxFit.cover,
        ),
      );
}
