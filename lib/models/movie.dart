List<Movie> moviesFromJson(Map<String, dynamic> json) =>
    (json['results'] as List<dynamic>)
        .map((json) => Movie.fromJson(json as Map<String, dynamic>))
        .toList();

class Movie {
  const Movie({
    this.id,
    this.title,
    this.overview,
    this.posterPath,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String,
      );

  final int id;
  final String title;
  final String overview;
  final String posterPath;
}
