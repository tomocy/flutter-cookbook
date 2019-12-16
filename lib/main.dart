import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        items: List<String>.generate(100, (i) => '$i'),
      ),
    );
  }
}

class Page extends StatelessWidget {
  const Page({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar(
            title: Text('Floating app bar'),
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) => ListTile(title: Text(items[i])),
              childCount: items.length,
            ),
          )
        ],
      ),
    );
  }
}
