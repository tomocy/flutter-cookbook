import 'package:flutter/material.dart';
import 'ui/movies_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        home: MoviesPage.create(context),
      );
}
