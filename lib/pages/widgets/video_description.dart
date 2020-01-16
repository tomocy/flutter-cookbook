import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    Key key,
    @required this.height,
  }) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '@tomocy',
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            Text('Video title', style: Theme.of(context).textTheme.caption),
            Text('Song title', style: Theme.of(context).textTheme.caption),
          ],
        ),
      );
}
