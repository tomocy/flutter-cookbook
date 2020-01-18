import 'dart:math';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/video_liker.dart';

class MockVideoLiker implements VideoLiker {
  final _videos = <Video>[];
  final _random = Random();

  @override
  Future<void> like(Video video) async => _likeOrUnlike(
        video,
        true,
      );

  @override
  Future<void> unlike(Video video) async => _likeOrUnlike(
        video,
        false,
      );

  Future<void> _likeOrUnlike(Video video, bool like) async {
    final liked = await isLiked(video);
    if (liked == like) {
      return;
    }

    if (_random.nextBool()) {
      throw VideoLikerException("failed to ${like ? 'like' : 'unlike'}");
    }
    if (like) {
      _videos.add(video);
    } else {
      _videos.remove(video);
    }
  }

  @override
  Future<bool> isLiked(Video video) async => _videos.contains(video);
}
