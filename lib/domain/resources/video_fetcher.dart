import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/resource.dart';

typedef VideoFetcher = Future<Video> Function(String title);

class VideoFetcherException extends ResourceException {
  const VideoFetcherException([String message]) : super(message);
}
