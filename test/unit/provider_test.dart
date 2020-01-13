import 'dart:io';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:cookbook/resources/movie_provider.dart';
import 'package:cookbook/models/movie.dart';
import 'package:cookbook/models/status.dart';

void main() {
  group('fetchMovie test', () {
    test('success', () async {
      final client = MockHttpClient();
      when(client.get('http://api.themoviedb.org/3/movie/popular?api_key=test'))
          .thenAnswer((_) async => Response(
                '''{"page": 1,"total_results": 19832,"total_pages": 992,"results": [{"vote_count": 302,"id": 420818,"video": false,"vote_average": 6.8,"title": "The Lion King","popularity": 502.676,"poster_path": "/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg","original_language": "en","original_title": "The Lion King","genre_ids": [12,16,10751,18,28],"backdrop_path": "/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg","adult": false,"overview": "Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub\'s arrival. Scar, Mufasa\'s brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba\'s exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.","release_date": "2019-07-12"}]}''',
                200,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));

      final provider = MovieProvider('test', client);
      expect(await provider.fetchMovies(),
          const TypeMatcher<SuccessStatus<List<Movie>>>());
    });

    test('failed', () async {
      final client = MockHttpClient();
      when(client.get('http://api.themoviedb.org/3/movie/popular?api_key=test'))
          .thenAnswer((_) async => Response(
                '''{"status_code":7,"status_message":"Invalid API key: You must be granted a valid key.","success":false}''',
                401,
                headers: {
                  HttpHeaders.contentTypeHeader:
                      'application/json; charset=utf-8',
                },
              ));

      final provider = MovieProvider('test', client);
      expect(await provider.fetchMovies(), const TypeMatcher<FailedStatus>());
    });
  });
}

class MockHttpClient extends Mock implements Client {}
