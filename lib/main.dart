import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        items: List<String>.generate(30, (i) => 'Item $i'),
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
      appBar: AppBar(
        title: const Text('Items'),
      ),
      body: ListView.builder(
        key: Key('item_list'),
        itemCount: items.length,
        itemBuilder: (context, i) => ListTile(
          title: Text(
            items[i],
            key: Key('item_$i'),
          ),
        ),
      ),
    );
  }
}
