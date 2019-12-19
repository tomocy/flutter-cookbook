import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(
        storage: CountStorage(),
      ),
    );
  }
}

class Page extends StatefulWidget {
  const Page({
    Key key,
    @required this.storage,
  }) : super(key: key);

  final CountStorage storage;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  int _count = 0;

  @override
  void initState() {
    super.initState();
    widget.storage.read().then((count) => setState(() => _count = count));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter')),
      body: Center(
        child: Text('Button tapped $_count time${_count >= 2 ? 's' : ''}'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() => _count++);
          widget.storage.write(_count);
        },
        tooltip: 'increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class CountStorage {
  Future<void> write(int count) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('count', count);
  }

  Future<int> read() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('count') ?? 0;
  }
}
