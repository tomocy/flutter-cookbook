import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(home: Page.create(context));
}

class Page extends StatelessWidget {
  const Page._({Key key}) : super(key: key);

  static Widget create(BuildContext _, {Key key}) => Provider<PageBloc>(
        create: (_) => PageBloc(),
        dispose: (_, bloc) => bloc.dispose(),
        child: Page._(key: key),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Counter')),
        body: Center(
          child: Consumer<PageBloc>(
            builder: (_, bloc, __) => StreamBuilder<int>(
              stream: bloc.count,
              initialData: 0,
              builder: (_, snapshot) =>
                  Text('You hit me ${snapshot.data} times.'),
            ),
          ),
        ),
        floatingActionButton: Consumer<PageBloc>(
          builder: (_, bloc, __) => FloatingActionButton(
            onPressed: () => bloc.increment.add(null),
            child: const Icon(Icons.add),
          ),
        ),
      );
}

class PageBloc {
  PageBloc() {
    _incrementController.stream.listen(_increment);
  }

  final _countController = StreamController<int>();
  var _count = 0;
  final _incrementController = StreamController<void>();

  Stream<int> get count => _countController.stream;

  Sink<void> get increment => _incrementController.sink;

  void _increment(void _) => _countController.sink.add(++_count);

  void dispose() {
    _countController.close();
    _incrementController.close();
  }
}
