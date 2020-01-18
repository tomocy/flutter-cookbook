import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/resource.dart';

abstract class VideoFetcher {
  Future<Video> fetch(String title);
}

class VideoFetcherException extends ResourceException {
  const VideoFetcherException([String message]) : super(message);
}
