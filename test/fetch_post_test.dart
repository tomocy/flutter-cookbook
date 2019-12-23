import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import 'package:cookbook/main.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('fetchPost', () {
    test('return a post if the http call completes successfully', () async {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response(
              '{"id": 1, "userId": 1, "title": "Test title", "body": "Test body"}',
              200));

      expect(await fetchPost(client), const TypeMatcher<Post>());
    });

    test('thows an exception if the http call completes with an error',
        () async {
      final client = MockClient();
      when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
          .thenAnswer((_) async => http.Response('Not found', 400));

      expect(fetchPost(client), throwsException);
    });
  });
}
