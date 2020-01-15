import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../blocs/like_movie_bloc.dart';
import '../models/movie.dart';
import 'movie_page.dart';
import 'widgets/movies_grid_view.dart';

class LikedMoviesPage extends StatelessWidget {
  const LikedMoviesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Liked Movies')),
        body: SafeArea(
          child: Consumer<LikeMovieBloc>(
            builder: (_, bloc, child) => StreamBuilder<List<Movie>>(
              stream: bloc.movies,
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  bloc.notify.add(null);
                  return child;
                }

                return MoviesGridView(
                  onTapMovie: (movie) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MoviePage(movie: movie)),
                  ),
                  movies: snapshot.data,
                );
              },
            ),
            child: const MoviesGridView(),
          ),
        ),
      );
}
