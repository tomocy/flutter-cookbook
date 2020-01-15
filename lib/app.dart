import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/like_movie_bloc.dart';
import 'blocs/resources/movies_fetcher.dart';
import 'pages/movies_page.dart';
import 'resources/movies_fetcher.dart';
import 'theme.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<MoviesFetcher>(create: (_) => fetchMockMovies),
          // ChangeNotifierProvider<LikedMovies>(create: (_) => LikedMovies()),
          Provider<LikeMovieBloc>(
            create: (_) => LikeMovieBloc(),
            dispose: (_, bloc) => bloc.dispose(),
          ),
        ],
        child: MaterialApp(
          theme: light,
          darkTheme: dark,
          home: const MoviesPage(),
        ),
      );
}
