import 'package:cookbook/domain/models/song.dart';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/video_liker.dart';
import 'package:cookbook/infra/video_liker.dart';
import 'package:cookbook/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData.from(colorScheme: const ColorScheme.dark()),
        home: Provider<VideoLiker>(
          create: (_) => MockVideoLiker(),
          child: const Home(
            video: Video(
              user: 'tomocy',
              title: 'Video title',
              song: Song(
                artist: 'Artist',
                album: 'Album',
                name: 'Song name',
              ),
            ),
          ),
        ),
      );
}
