import 'package:cookbook/domain/models/song.dart';

class Video {
  const Video({
    this.user,
    this.title,
    this.song,
    this.uri,
  });

  final String user;
  final String title;
  final String uri;
  final Song song;

  String get userId => '@$user';

  @override
  bool operator ==(dynamic other) => other is Video && other.title == title;

  @override
  int get hashCode => identityHashCode(title);
}
