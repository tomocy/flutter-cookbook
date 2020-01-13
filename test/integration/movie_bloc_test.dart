import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:cookbook/resources/repository.dart';
import 'package:cookbook/resources/movie_provider.dart';
import 'package:cookbook/bloc/movie_bloc.dart';
import 'package:cookbook/models/movie.dart';

void main() {
  group('MovieBLoc test', () {
    test('success', () async {
      final repository = Repository(
          MovieProvider('802b2c4b88ea1183e50e6b285a27696e', Client()));
      final bloc = MovieBloc(repository);
      bloc.movies
          .listen((movies) => expect(movies, const TypeMatcher<List<Movie>>()));
      bloc.fetch.add(null);
    });

    test('failed', () async {
      final repository = Repository(MovieProvider('test', Client()));
      final bloc = MovieBloc(repository);
      bloc.movies.listen(
        null,
        onError: (error) => expect(error, const TypeMatcher<Exception>()),
      );
      bloc.fetch.add(null);
    });
  });
}
