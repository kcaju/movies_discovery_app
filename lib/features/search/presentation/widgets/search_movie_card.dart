import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../dashboard/data/models/movie_model.dart';
import '../../../movie_details/presentation/screens/movie_details_screen.dart';

class SearchMovieCard extends StatelessWidget {
  final MovieModel movie;

  const SearchMovieCard({super.key, required this.movie});

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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border, width: 0.8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImage(
              imageUrl: movie.fullPosterUrl,
              width: 80,
              height: 115,
              borderRadius: 8,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.titleLarge.copyWith(fontSize: 15),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, size: 16, color: AppColors.ratingYellow),
                      const SizedBox(width: 4),
                      Text(
                        movie.formattedRating,
                        style: AppTypography.caption.copyWith(
                          color: AppColors.ratingYellow,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (movie.releaseYear.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        const Text('•', style: TextStyle(color: AppColors.textMuted)),
                        const SizedBox(width: 8),
                        Text(movie.releaseYear, style: AppTypography.caption),
                      ],
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview.isNotEmpty ? movie.overview : 'No description available.',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
