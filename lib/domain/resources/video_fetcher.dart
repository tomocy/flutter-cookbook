import 'package:cookbook/domain/models/video.dart';

typedef VideoFetcher = Future<Video> Function(String title);

class VideoFetcherException implements Exception {}
