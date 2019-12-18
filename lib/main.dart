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
      appBar: AppBar(
        title: const Text('page'),
      ),
      body: const Center(
        child: SelectionButton(),
      ),
    );
  }
}

class SelectionButton extends StatelessWidget {
  const SelectionButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () => _displaySelection(context),
      child: const Text('to selection page'),
    );
  }

  void _displaySelection(BuildContext context) async {
    final selected = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SelectionPage(),
      ),
    );

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text(selected.toString()),
      ));
  }
}

class SelectionPage extends StatelessWidget {
  const SelectionPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () => Navigator.pop(context, 'Yep'),
              child: const Text('Yep'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RaisedButton(
              onPressed: () => Navigator.pop(context, 'Nope'),
              child: const Text('Nope'),
            ),
          ),
        ],
      ),
    );
  }
}
