import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../dashboard/data/models/movie_model.dart';
import '../../../movie_details/presentation/screens/movie_details_screen.dart';
import '../bloc/coming_soon_bloc.dart';
import '../bloc/coming_soon_event.dart';
import '../bloc/coming_soon_state.dart';
import '../widgets/upcoming_card.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  String _formatNotificationDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return 'Recent';
    try {
      final dateTime = DateTime.parse(rawDate);
      return DateFormat('MMM d').format(dateTime);
    } catch (_) {
      return 'Recent';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ComingSoonBloc, ComingSoonState>(
          builder: (context, state) {
            if (state is ComingSoonLoading) {
              return _buildLoadingShimmer();
            } else if (state is ComingSoonError) {
              return ErrorView(
                message: state.message,
                onRetry: () {
                  context
                      .read<ComingSoonBloc>()
                      .add(const FetchComingSoonMoviesEvent());
                },
              );
            } else if (state is ComingSoonEmpty) {
              return EmptyView(
                title: 'No Upcoming Releases',
                message: state.message,
                action: ElevatedButton(
                  onPressed: () {
                    context
                        .read<ComingSoonBloc>()
                        .add(const FetchComingSoonMoviesEvent());
                  },
                  child: const Text('Refresh'),
                ),
              );
            } else if (state is ComingSoonLoaded) {
              final movies = state.movies;
              final notificationMovies = movies.take(2).toList();

              return RefreshIndicator(
                color: AppColors.primary,
                backgroundColor: AppColors.surface,
                onRefresh: () async {
                  context
                      .read<ComingSoonBloc>()
                      .add(const FetchComingSoonMoviesEvent(isRefresh: true));
                },
                child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  children: [
                    // 1. Notifications Header
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: Color(0xFFE50914),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.notifications,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Notifications',
                            style: AppTypography.headingMedium.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // 2. Notifications List Items (New Arrivals)
                    if (notificationMovies.isNotEmpty) ...[
                      ...notificationMovies.map(
                        (movie) => _buildNotificationItem(context, movie),
                      ),
                      const SizedBox(height: 8),
                      const Divider(
                        color: Color(0xFF2B2B2B),
                        thickness: 1,
                        height: 1,
                      ),
                      const SizedBox(height: 12),
                    ],

                    // 3. Upcoming Movies Feed
                    ...movies.map((movie) => UpcomingCard(movie: movie)),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, MovieModel movie) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Video/Movie Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: CachedImage(
                imageUrl: movie.fullBackdropUrl ?? movie.fullPosterUrl,
                width: 115,
                height: 65,
                fit: BoxFit.cover,
                borderRadius: 4,
              ),
            ),
            const SizedBox(width: 14),

            // Metadata: New Arrival / Title / Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'New Arrival',
                    style: AppTypography.titleMedium.copyWith(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.bodySmall.copyWith(
                      color: const Color(0xFFC4C4C4),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatNotificationDate(movie.releaseDate),
                    style: AppTypography.caption.copyWith(
                      color: const Color(0xFF808080),
                      fontSize: 11.5,
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

  Widget _buildLoadingShimmer() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                  width: double.infinity, height: 210, borderRadius: 0),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(width: 120, height: 14, borderRadius: 4),
                    SizedBox(height: 8),
                    ShimmerLoading(width: 220, height: 20, borderRadius: 4),
                    SizedBox(height: 10),
                    ShimmerLoading(
                        width: double.infinity, height: 14, borderRadius: 4),
                    SizedBox(height: 6),
                    ShimmerLoading(
                        width: double.infinity, height: 14, borderRadius: 4),
                    SizedBox(height: 6),
                    ShimmerLoading(width: 140, height: 14, borderRadius: 4),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
