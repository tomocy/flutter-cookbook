import 'package:flutter/material.dart';

class TikTokButton extends StatelessWidget {
  const TikTokButton({
    Key key,
    @required this.onPressed,
    this.size = 24,
  })  : assert(onPressed != null),
        super(key: key);

  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) => InkResponse(
        canRequestFocus: onPressed != null,
        onTap: onPressed,
        child: Stack(
          alignment: Alignment.center,
          overflow: Overflow.visible,
          children: [
            Positioned(
              right: -size / 6,
              child: _buildColorBox(color: const Color(0xFFFF2D6C)),
            ),
            Positioned(
              left: -size / 6,
              child: _buildColorBox(color: const Color(0xFF20D3EA)),
            ),
            _buildColorBox(color: Colors.white),
            Icon(
              Icons.add,
              color: Colors.black,
              size: size,
            ),
          ],
        ),
      );

  Widget _buildColorBox({
    Color color,
  }) =>
      Container(
        width: size * 4 / 3,
        height: size,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(7),
        ),
      );
}
