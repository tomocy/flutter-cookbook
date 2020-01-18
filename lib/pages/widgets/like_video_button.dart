import 'package:cookbook/blocs/video_liker_bloc.dart';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/pages/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikeVideoButton extends StatefulWidget {
  const LikeVideoButton({
    Key key,
    this.color,
    @required this.video,
  }) : super(key: key);

  final Color color;
  final Video video;

  @override
  _LikeVideoButtonState createState() => _LikeVideoButtonState();
}

class _LikeVideoButtonState extends State<LikeVideoButton> {
  bool _wasLiked = false;

  @override
  Widget build(BuildContext context) => Consumer<VideoLikerBloc>(
        builder: (_, bloc, child) => StreamBuilder<bool>(
          stream: bloc.liked,
          builder: (context, snapshot) {
            if (!snapshot.hasData && !snapshot.hasError) {
              bloc.isLiked.add(widget.video);
              return child;
            }

            if (snapshot.hasError) {
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => Scaffold.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text(snapshot.error.toString()),
                    )));
            }

            final liked = snapshot.hasError ? _wasLiked : snapshot.data;
            _wasLiked = liked;

            return liked
                ? ActionButton(
                    onPressed: () => bloc.unlike.add(widget.video),
                    color: Theme.of(context).colorScheme.secondary,
                    iconData: Icons.thumb_up,
                    label: '16.4k',
                  )
                : ActionButton(
                    onPressed: () => bloc.like.add(widget.video),
                    color: widget.color,
                    iconData: Icons.thumb_up,
                    label: '16.4k',
                  );
          },
        ),
        child: Icon(
          Icons.more_horiz,
          color: widget.color,
        ),
      );
}
