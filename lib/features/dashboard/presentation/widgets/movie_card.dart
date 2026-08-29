import 'package:flutter/material.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../movie_details/presentation/screens/movie_details_screen.dart';
import '../../data/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;
  final double width;
  final double height;

  const MovieCard({
    super.key,
    required this.movie,
    this.width = 110,
    this.height = 160,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        width: width,
        height: height,
        margin: const EdgeInsets.only(right: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: CachedImage(
            imageUrl: movie.fullPosterUrl,
            width: width,
            height: height,
            fit: BoxFit.cover,
            borderRadius: 4,
          ),
        ),
      ),
    );
  }
}
