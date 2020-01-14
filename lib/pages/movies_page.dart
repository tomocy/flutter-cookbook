import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/movies_bloc.dart';
import '../blocs/resources/movies_fetcher.dart';
import '../models/movie.dart';
import 'widgets/movie_tile.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage._({Key key}) : super(key: key);

  static Widget create({Key key}) => Consumer<MoviesFetcher>(
        builder: (_, fetcher, __) => Provider<MoviesBloc>(
          create: (_) => MoviesBloc(fetcher)..fetch.add(null),
          dispose: (_, bloc) => bloc.dispose(),
          child: MoviesPage._(key: key),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer<MoviesBloc>(
            builder: (_, bloc, child) => StreamBuilder<List<Movie>>(
              stream: bloc.movies,
              initialData: const [],
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, i) => Padding(
                      padding: const EdgeInsets.all(4),
                      child: MovieTile(movie: snapshot.data[i]),
                    ),
                  );
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
            child: ListView(),
          ),
        ),
      );
}
