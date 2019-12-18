import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ExtractArgumentsScreen.routeName: (context) =>
            const ExtractArgumentsScreen(),
      },
      home: const Page(),
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
      body: Center(
        child: RaisedButton(
          onPressed: () => Navigator.pushNamed(
            context,
            '/args',
            arguments: const RouteArguments(
              'arg title',
              'arg message',
            ),
          ),
          child: const Text('to args'),
        ),
      ),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/args';

  const ExtractArgumentsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as RouteArguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
  }
}

class RouteArguments {
  const RouteArguments(this.title, this.message);

  final String title;
  final String message;
}
