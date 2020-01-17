import 'package:cookbook/domain/models/song.dart';

class Video {
  const Video({
    this.user,
    this.title,
    this.song,
  });

  final String user;
  final String title;
  final Song song;

  String get userId => '@$user';
}
