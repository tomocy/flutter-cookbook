import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

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
  Future<File> write(int count) async {
    final file = await _file();
    return file.writeAsString('$count');
  }

  Future<int> read() async {
    final file = await _file();
    final raw = await file.readAsString();
    return int.parse(raw);
  }

  Future<File> _file() async {
    final path = await _path();
    return File(join(path, 'counter.txt'));
  }

  Future<String> _path() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }
}
