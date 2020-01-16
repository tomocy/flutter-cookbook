import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  const FollowButton({
    Key key,
    @required this.onPressed,
    this.size,
  })  : assert(onPressed != null),
        super(key: key);

  final VoidCallback onPressed;
  final double size;

  double _size(BuildContext context) =>
      size ?? Theme.of(context).iconTheme.size ?? 36;

  double _iconSize(BuildContext context) => _size(context) * 2 / 5;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      canRequestFocus: onPressed != null,
      onTap: onPressed,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          FlutterLogo(size: _size(context)),
          Positioned(
            bottom: -_iconSize(context) / 2,
            child: Container(
              width: _iconSize(context),
              height: _iconSize(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary,
              ),
              child: Icon(
                Icons.add,
                size: _iconSize(context),
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
