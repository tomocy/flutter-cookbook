import 'package:cookbook/pages/widgets/action_button.dart';
import 'package:cookbook/pages/widgets/follow_button.dart';
import 'package:flutter/material.dart';

class SocialActionButtonSheet extends StatelessWidget {
  const SocialActionButtonSheet({
    Key key,
    @required this.mainAxisAlignment,
    @required this.crossAxisAlignment,
    this.color,
  })  : assert(mainAxisAlignment != null),
        assert(crossAxisAlignment != null),
        super(key: key);

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: _buildActionButtons(context)
            .map((button) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: button,
                ))
            .toList(),
      );

  List<Widget> _buildActionButtons(BuildContext context) => [
        const FollowButton(),
        ActionButton(
          onPressed: () {},
          color: color,
          iconData: Icons.android,
          label: '3.2m',
        ),
        ActionButton(
          onPressed: () {},
          color: color,
          iconData: Icons.thumb_up,
          label: '16.4k',
        ),
        ActionButton(
          onPressed: () {},
          color: color,
          iconData: Icons.share,
          label: 'Share',
        ),
      ];
}
