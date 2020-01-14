import 'package:flutter/material.dart';
import '../../models/movie.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key key,
    this.onTap,
    @required this.movie,
  })  : assert(movie != null),
        super(key: key);

  final VoidCallback onTap;
  final Movie movie;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Card(
              margin: const EdgeInsets.all(0),
              child: Image.network(
                movie.posterUri,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              color: Colors.black.withOpacity(0.5),
              child: Text(
                movie.title,
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      );
}
