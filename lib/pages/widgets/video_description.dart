import 'package:cookbook/domain/models/video.dart';
import 'package:flutter/material.dart';

class VideoDescription extends StatelessWidget {
  const VideoDescription({
    Key key,
    this.color,
    @required this.video,
  }) : super(key: key);

  final Color color;
  final Video video;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video.userId,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            video.title,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: color,
                ),
          ),
          Row(
            children: [
              Icon(
                Icons.music_note,
                size: Theme.of(context).textTheme.caption.fontSize,
                color: color,
              ),
              Text(
                '''${video.song.artist} - ${video.song.artist} - ${video.song.name}''',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: color,
                    ),
              ),
            ],
          ),
        ],
      );
}
