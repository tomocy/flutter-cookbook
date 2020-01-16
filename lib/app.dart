import 'package:cookbook/pages/home.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.from(colorScheme: const ColorScheme.dark()),
        home: const Home(),
      );
}
