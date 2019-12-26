import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
        home: Page(),
      );
}

class Page extends StatefulWidget {
  const Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  double _width = 150;
  double _height = 150;
  Color _color = Colors.black;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(0);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => setState(() => _changeRandomly()),
          child: const Icon(Icons.scatter_plot),
        ),
      );

  void _changeRandomly() {
    final random = Random();

    _width = random.nextInt(300).toDouble();
    _height = random.nextInt(300).toDouble();
    _color = Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      random.nextDouble(),
    );
    _borderRadius = BorderRadius.circular(random
        .nextInt(_width < _height ? _width ~/ 2 : _height ~/ 2)
        .toDouble());
  }
}
