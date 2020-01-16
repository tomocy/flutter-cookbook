import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    @required this.onPressed,
    this.color,
    @required this.iconData,
    @required this.label,
  })  : assert(onPressed != null),
        assert(iconData != null),
        assert(label != null),
        super(key: key);

  final VoidCallback onPressed;
  final Color color;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) => FlatButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(iconData, color: color),
            const SizedBox(height: 5),
            Text(
              label,
              style: Theme.of(context).textTheme.caption.copyWith(color: color),
            ),
          ],
        ),
      );
}
