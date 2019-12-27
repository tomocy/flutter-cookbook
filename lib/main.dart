import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Page());
}

class Page extends StatefulWidget {
  const Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..forward()
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
  Widget build(BuildContext context) => Center(
        child: _GrowTransition(
          animation: _controller,
          child: const FlutterLogo(),
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _GrowTransition extends StatelessWidget {
  _GrowTransition({
    Key key,
    this.animation,
    this.child,
  }) : super(key: key);

  final Animation<double> animation;
  final Widget child;
  final _opacityAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  );
  final _sizeAnimation = Tween<double>(
    begin: 0.0,
    end: 300.0,
  );

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) => Opacity(
          opacity: _opacityAnimation.evaluate(animation),
          child: SizedBox(
            width: _sizeAnimation.evaluate(animation),
            height: _sizeAnimation.evaluate(animation),
            child: child,
          ),
        ),
        child: child,
      );
}
