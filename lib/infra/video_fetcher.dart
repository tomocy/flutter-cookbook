import 'package:cookbook/domain/models/song.dart';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/video_fetcher.dart';

class MockVideoFetcher implements VideoFetcher {
  @override
  Future<Video> fetch(String title) async => Video(
        user: 'tomocy',
        title: title,
        uri: 'images/movie.jpeg',
        song: Song(
          artist: 'Artist',
          album: 'Album',
          name: 'Song name',
        ),
      );
}
