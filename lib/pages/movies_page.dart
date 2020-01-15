import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/fetch_movies_bloc.dart';
import '../blocs/resources/movies_fetcher.dart';
import '../models/movie.dart';
import 'liked_movies_page.dart';
import 'movie_page.dart';
import 'widgets/movies_grid_view.dart';
import 'widgets/filter_movie_delegate.dart';

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
              icon: const Icon(Icons.thumb_up),
            ),
          ],
        ),
        body: SafeArea(
          child: Consumer<FetchMoviesBloc>(
            builder: (_, bloc, child) => StreamBuilder<List<Movie>>(
              stream: bloc.movies,
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  bloc.fetch.add(null);
                  return child;
                }

                if (snapshot.hasError) {
                  WidgetsBinding.instance
                      .addPostFrameCallback((_) => Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content: Text(snapshot.error.toString()),
                        )));

                  return child;
                }

                return MoviesGridView(
                  onTapMovie: (movie) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MoviePage(movie: movie),
                    ),
                  ),
                  movies: snapshot.data,
                );
              },
            ),
            child: const MoviesGridView(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => showSearch(
            context: context,
            delegate: FilterMovieDelegate(),
          ),
          child: const Icon(Icons.search),
        ),
      );
}
