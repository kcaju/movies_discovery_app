import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../dashboard/data/models/movie_model.dart';
import '../../../movie_details/presentation/screens/movie_details_screen.dart';

class UpcomingCard extends StatefulWidget {
  final MovieModel movie;

  const UpcomingCard({super.key, required this.movie});

  @override
  State<UpcomingCard> createState() => _UpcomingCardState();
}

class _UpcomingCardState extends State<UpcomingCard> {
  bool _isReminded = false;

  static const Map<int, String> _genreMap = {
    28: 'Action',
    12: 'Adventure',
    16: 'Animation',
    35: 'Comedy',
    80: 'Crime',
    99: 'Documentary',
    18: 'Drama',
    10751: 'Family',
    14: 'Fantasy',
    36: 'History',
    27: 'Horror',
    10402: 'Music',
    9648: 'Mystery',
    10749: 'Romance',
    878: 'Sci-Fi',
    10770: 'TV Movie',
    53: 'Suspenseful',
    10752: 'War',
    37: 'Western',
  };

  String _formatReleaseDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return 'Coming Soon';
    try {
      final dateTime = DateTime.parse(rawDate);
      return 'Coming ${DateFormat('MMMM d').format(dateTime)}';
    } catch (_) {
      return 'Coming Soon';
    }
  }

  String _getGenreTags() {
    if (widget.movie.genreIds.isNotEmpty) {
      final names = widget.movie.genreIds
          .map((id) => _genreMap[id])
          .whereType<String>()
          .take(5)
          .toList();
      if (names.isNotEmpty) {
        return names.join('  •  ');
      }
    }
    return 'Steamy  •  Soapy  •  Slow Burn  •  Suspenseful  •  Mystery';
  }

  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 28),
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Full-width Hero Video/Backdrop Image
            CachedImage(
              imageUrl: movie.fullBackdropUrl ?? movie.fullPosterUrl,
              width: double.infinity,
              height: 210,
              fit: BoxFit.cover,
              borderRadius: 0,
            ),

            // 2. Action Icons Row (Remind Me, Share)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isReminded = !_isReminded;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isReminded
                                ? 'Reminder set for ${movie.title}!'
                                : 'Reminder removed for ${movie.title}.',
                          ),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isReminded
                                ? Icons.notifications_active
                                : Icons.notifications_none_rounded,
                            color: _isReminded ? Colors.white : Colors.white,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Remind Me',
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Sharing "${movie.title}"...'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    child: Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.share_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Share',
                            style: AppTypography.caption.copyWith(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 3. Movie Details (Release Date, Title, Overview, Tags)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatReleaseDate(movie.releaseDate),
                    style: AppTypography.caption.copyWith(
                      color: const Color(0xFFC4C4C4),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    movie.title,
                    style: AppTypography.headingMedium.copyWith(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.overview.isNotEmpty
                        ? movie.overview
                        : 'A story packed with drama, action and suspense, coming soon to stream on Netflix.',
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFF9E9E9E),
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _getGenreTags(),
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white,
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
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
