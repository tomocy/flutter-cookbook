import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../blocs/fetch_movies_bloc.dart';
import '../../models/movie.dart';
import '../movie_page.dart';
import 'movies_grid_view.dart';

class FilterMovieDelegate extends SearchDelegate<String> {
  @override
  ThemeData appBarTheme(BuildContext context) => Theme.of(context);

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          onPressed: () => query = '',
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, query),
        icon: AnimatedIcon(
          progress: transitionAnimation,
          icon: AnimatedIcons.menu_arrow,
        ),
      );

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);

  @override
  Widget buildResults(BuildContext context) => Consumer<FetchMoviesBloc>(
        builder: (_, bloc, child) => StreamBuilder<List<Movie>>(
          stream: bloc.filteredMovies,
          builder: (_, snapshot) {
            bloc.filter.add(query);

            if (!snapshot.hasData) {
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
      );
}
