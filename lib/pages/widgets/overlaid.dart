import 'package:flutter/material.dart';

class Overlaid extends StatelessWidget {
  const Overlaid({
    Key key,
    this.background,
    this.color,
    this.foreground,
  }) : super(key: key);

  final Widget background;
  final Color color;
  final Widget foreground;

  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          Card(
            margin: const EdgeInsets.all(0),
            child: background,
          ),
          Container(
            color: color,
            child: foreground,
          ),
        ],
      );
}
