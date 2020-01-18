import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/resource.dart';

abstract class VideoLiker {
  Future<bool> isLiked(Video video);

  Future<void> like(Video video);

  Future<void> unlike(Video video);
}

class VideoLikerException extends ResourceException {
  const VideoLikerException([String message]) : super(message);
}
