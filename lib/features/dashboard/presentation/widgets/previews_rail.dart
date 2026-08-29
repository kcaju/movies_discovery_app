import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/cached_image.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../../movie_details/presentation/screens/movie_details_screen.dart';
import '../../data/models/movie_model.dart';

class PreviewsRail extends StatefulWidget {
  final List<MovieModel> movies;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;

  const PreviewsRail({
    super.key,
    required this.movies,
    this.onLoadMore,
    this.isLoadingMore = false,
  });

  @override
  State<PreviewsRail> createState() => _PreviewsRailState();
}

class _PreviewsRailState extends State<PreviewsRail> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (widget.onLoadMore == null || widget.isLoadingMore) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 150) {
      widget.onLoadMore!();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) return const SizedBox.shrink();

    final totalCount = widget.movies.length + (widget.isLoadingMore ? 1 : 0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Previews',
            style: AppTypography.headingMedium.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        SizedBox(
          height: 115,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            physics: const BouncingScrollPhysics(),
            itemCount: totalCount,
            itemBuilder: (context, index) {
              if (index < widget.movies.length) {
                final movie = widget.movies[index];
                return _buildPreviewItem(context, movie);
              } else {
                return const Padding(
                  padding: EdgeInsets.only(right: 14.0),
                  child: ShimmerLoading.circular(size: 102),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPreviewItem(BuildContext context, MovieModel movie) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movie: movie),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 14),
        width: 102,
        height: 102,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.borderLight.withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.5),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: CachedImage(
          imageUrl: movie.fullPosterUrl ?? movie.fullBackdropUrl,
          fit: BoxFit.cover,
          width: 102,
          height: 102,
          borderRadius: 51,
        ),
      ),
    );
  }
}
