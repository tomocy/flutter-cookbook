import 'package:cookbook/domain/models/video.dart';

typedef VideoFetcher = Future<Video> Function(String title);

class VideoFetcherException extends Exception {
  factory VideoFetcherException([String message]) =>
      VideoFetcherException(message);
}
