import 'package:cookbook/domain/models/video.dart';

abstract class VideoLiker {
  Future<bool> isLiked(Video video);

  Future<void> like(Video video);

  Future<void> unlike(Video video);
}

class VideoLikerException implements Exception {
  const VideoLikerException([this.message]);

  final String message;
}
