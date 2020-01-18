import 'dart:async';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/video_liker.dart';

class VideoLikerBloc {
  VideoLikerBloc(this._liker) {
    _isLikedController.stream.listen(_invokeIsLiked);
    _likeController.stream.listen(_invokeLike);
    _unlikeController.stream.listen(_invokeUnlike);
  }

  final VideoLiker _liker;
  final _likedController = StreamController<bool>.broadcast();
  final _isLikedController = StreamController<Video>();
  final _likeController = StreamController<Video>();
  final _unlikeController = StreamController<Video>();

  Stream<bool> get liked => _likedController.stream;

  Sink<Video> get isLiked => _isLikedController.sink;

  Sink<Video> get like => _likeController.sink;

  Sink<Video> get unlike => _unlikeController.sink;

  void _invokeLike(Video video) => _invokeLikeOrUnlike(video, true);

  void _invokeUnlike(Video video) => _invokeLikeOrUnlike(video, false);

  Future<void> _invokeLikeOrUnlike(Video video, bool like) async {
    try {
      if (like) {
        await _liker.like(video);
      } else {
        await _liker.unlike(video);
      }
      _likedController.add(like);
    } on VideoLikerException catch (e) {
      _likedController.addError(e);
    }
  }

  Future<void> _invokeIsLiked(Video video) async {
    try {
      final liked = await _liker.isLiked(video);
      _likedController.add(liked);
    } on VideoLikerException catch (e) {
      _likedController.addError(e);
    }
  }

  void dispose() {
    _likedController.close();
    _isLikedController.close();
    _likeController.close();
    _unlikeController.close();
  }
}
