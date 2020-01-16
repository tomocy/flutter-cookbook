import 'package:cookbook/pages/widgets/action_button.dart';
import 'package:flutter/material.dart';

class ActionButtonSheet extends StatelessWidget {
  const ActionButtonSheet({
    Key key,
    this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ActionButton(
              onPressed: () {},
              color: color,
              iconData: Icons.android,
              label: '3.2m',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ActionButton(
              onPressed: () {},
              color: color,
              iconData: Icons.thumb_up,
              label: '16.4k',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ActionButton(
              onPressed: () {},
              color: color,
              iconData: Icons.share,
              label: 'Share',
            ),
          ),
        ],
      );
}
