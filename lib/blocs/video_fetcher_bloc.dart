import 'dart:async';
import 'package:cookbook/domain/models/video.dart';
import 'package:cookbook/domain/resources/video_fetcher.dart';

class VideoFetcherBloc {
  VideoFetcherBloc(this._fetcher) {
    _fetchController.stream.listen(_invokeFetch);
  }

  final VideoFetcher _fetcher;
  final _videoController = StreamController<Video>();
  final _fetchController = StreamController<String>();

  Stream<Video> get video => _videoController.stream;

  Sink<String> get fetch => _fetchController.sink;

  Future<void> _invokeFetch(String title) async {
    try {
      final video = await _fetcher.fetch(title);
      _videoController.add(video);
    } on VideoFetcherException catch (e) {
      _videoController.addError(e);
    }
  }

  void dispose() {
    _videoController.close();
    _fetchController.close();
  }
}
