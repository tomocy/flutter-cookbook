class Video {
  const Video({
    this.user,
    this.title,
  });

  final String user;
  final String title;

  String get userId => '@$user';
}
