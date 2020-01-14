import 'package:flutter/material.dart';
import 'pages/movies_page.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: MoviesPage());
}
