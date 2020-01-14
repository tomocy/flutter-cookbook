class Movie {
  const Movie({
    this.id,
    this.score,
    this.title,
    this.overview,
    this.posterUri,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as int,
        score: json['vote_average'] as double,
        title: json['title'] as String,
        overview: json['overview'] as String,
        posterUri: "http://image.tmdb.org/t/p/w185/${json['poster_path']}",
      );

  final int id;
  final double score;
  final String title;
  final String overview;
  final String posterUri;

  @override
  bool operator ==(dynamic other) => other is Movie && other.id == other.id;

  @override
  int get hashCode => id;
}
