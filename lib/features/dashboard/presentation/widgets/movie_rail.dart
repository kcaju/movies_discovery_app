import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../../data/models/movie_model.dart';
import 'movie_card.dart';

class MovieRail extends StatefulWidget {
  final String title;
  final List<MovieModel> movies;
  final VoidCallback? onSeeAll;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;

  const MovieRail({
    super.key,
    required this.title,
    required this.movies,
    this.onSeeAll,
    this.onLoadMore,
    this.isLoadingMore = false,
  });

  @override
  State<MovieRail> createState() => _MovieRailState();
}

class _MovieRailState extends State<MovieRail> {
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: AppTypography.headingSmall,
              ),
              if (widget.onSeeAll != null)
                TextButton(
                  onPressed: widget.onSeeAll,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(50, 30),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'See All',
                    style: AppTypography.caption.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 160,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: totalCount,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < widget.movies.length) {
                return MovieCard(movie: widget.movies[index]);
              } else {
                return const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: ShimmerLoading(
                    width: 110,
                    height: 160,
                    borderRadius: 4,
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
