import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/resources/movies_fetcher.dart';
import 'pages/movies_page.dart';
import 'resources/movies_fetcher.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<MoviesFetcher>(create: (_) => fetchMockMovies),
        ],
        child: MaterialApp(home: MoviesPage.create()),
      );
}
