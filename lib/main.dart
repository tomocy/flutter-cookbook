import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatelessWidget {
  const Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}

abstract class ListItem {
  const ListItem();
}

class HeadingItem extends ListItem {
  const HeadingItem(this.heading);

  final String heading;
}
