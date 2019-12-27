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

class Page extends StatefulWidget {
  const Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    _animation = Tween<double>(
      begin: 0.0,
      end: 300.0,
    ).animate(_controller)
      ..addStatusListener((status) {
        switch (status) {
          case AnimationStatus.completed:
            _controller.reverse();
            break;
          case AnimationStatus.dismissed:
            _controller.forward();
            break;
          default:
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _AnimatedLogo(
        animation: _animation,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _AnimatedLogo extends AnimatedWidget {
  const _AnimatedLogo({
    Key key,
    Animation<double> animation,
  }) : super(
          key: key,
          listenable: animation,
        );

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;

    return SizedBox(
      width: animation.value,
      height: animation.value,
      child: const FlutterLogo(),
    );
  }
}
