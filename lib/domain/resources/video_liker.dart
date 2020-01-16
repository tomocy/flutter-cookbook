import 'package:cookbook/domain/models/video.dart';

abstract class VideoLiker {
  Future<bool> isLiked(Video video);

  Future<void> like(Video video);

  Future<void> unlike(Video video);
}

class VideoLikerException extends Exception {
  factory VideoLikerException([String message]) => VideoLikerException(message);
}
