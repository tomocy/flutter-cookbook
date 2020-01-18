import 'package:cookbook/domain/models/song.dart';
import 'package:cookbook/domain/models/video.dart';

Future<Video> fetchMockVideo(String _) async => const Video(
      user: 'tomocy',
      title: 'Video title',
      uri: 'images/movie.jpeg',
      song: Song(
        artist: 'Artist',
        album: 'Album',
        name: 'Song name',
      ),
    );
