import 'package:cookbook/blocs/video_liker_bloc.dart';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/pages/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeVideoButton extends StatelessWidget {
  const LikeVideoButton({
    Key key,
    this.color,
    @required this.video,
  }) : super(key: key);

  final Color color;
  final Video video;

  @override
  Widget build(BuildContext context) => Consumer<VideoLikerBloc>(
        builder: (_, bloc, child) => StreamBuilder<bool>(
          stream: bloc.liked,
          builder: (context, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              bloc.isLiked.add(video);
              return child;
            }

            var liked = snapshot.data;
            if (snapshot.hasError) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(snapshot.error.toString()),
                    )));
              liked = false;
            }

            return liked
                ? ActionButton(
                    onPressed: () => bloc.unlike.add(video),
                    color: Theme.of(context).colorScheme.secondary,
                    iconData: Icons.thumb_up,
                    label: '16.4k',
                  )
                : ActionButton(
                    onPressed: () => bloc.like.add(video),
                    color: color,
                    iconData: Icons.thumb_up,
                    label: '16.4k',
                  );
          },
        ),
        child: Icon(
          Icons.more_horiz,
          color: color,
        ),
      );
}
