import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/fetch_movies_bloc.dart';
import '../blocs/resources/movies_fetcher.dart';
import '../models/movie.dart';
import 'liked_movies_page.dart';
import 'movie_page.dart';
import 'widgets/movies_grid_view.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Movies'),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LikedMoviesPage()),
              ),
              icon: const Icon(Icons.favorite),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer<MoviesFetcher>(
            builder: (_, fetcher, __) => Provider<FetchMoviesBloc>(
              create: (_) => FetchMoviesBloc(fetcher)..fetch.add(null),
              dispose: (_, bloc) => bloc.dispose(),
              child: Consumer<FetchMoviesBloc>(
                builder: (_, bloc, child) => StreamBuilder<List<Movie>>(
                  stream: bloc.movies,
                  initialData: const [],
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return MoviesGridView(
                        onTapMovie: (movie) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MoviePage(movie: movie),
                          ),
                        ),
                        movies: snapshot.data,
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
          ),
        ),
      );
}
