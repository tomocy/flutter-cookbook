import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/liked_movies.dart';
import 'movie_page.dart';
import 'widgets/movies_grid_view.dart';

class LikedMoviesPage extends StatelessWidget {
  const LikedMoviesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Liked Movies')),
        body: SafeArea(
          child: Consumer<LikedMovies>(
            builder: (_, liked, __) => MoviesGridView(
              onTapMovie: (movie) => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => MoviePage(movie: movie)),
              ),
              movies: liked.movies,
            ),
          ),
        ),
      );
}
