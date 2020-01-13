import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart';
import 'resources/movie_provider.dart';
import 'resources/repository.dart';
import 'ui/movies_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<Repository>(
            create: (_) => Repository(MovieProvider(
              '802b2c4b88ea1183e50e6b285a27696e',
              Client(),
            )),
          ),
        ],
        child: MaterialApp(
          home: MoviesPage.create(context),
        ),
      );
}
