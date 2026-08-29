import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../bloc/dashboard_bloc.dart';
import '../bloc/dashboard_event.dart';
import '../bloc/dashboard_state.dart';
import '../widgets/featured_banner.dart';
import '../widgets/movie_rail.dart';
import '../widgets/previews_rail.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return _buildLoadingShimmer();
          } else if (state is DashboardError) {
            return ErrorView(
              message: state.message,
              onRetry: () {
                context
                    .read<DashboardBloc>()
                    .add(const FetchDashboardDataEvent());
              },
            );
          } else if (state is DashboardEmpty) {
            return EmptyView(
              title: 'No Movies Found',
              message: state.message,
              action: ElevatedButton(
                onPressed: () {
                  context
                      .read<DashboardBloc>()
                      .add(const FetchDashboardDataEvent());
                },
                child: const Text('Refresh'),
              ),
            );
          } else if (state is DashboardLoaded) {
            return RefreshIndicator(
              color: AppColors.primary,
              backgroundColor: AppColors.surface,
              onRefresh: () async {
                context
                    .read<DashboardBloc>()
                    .add(const FetchDashboardDataEvent(isRefresh: true));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FeaturedBanner(movie: state.featuredMovie),
                    const SizedBox(height: 16),
                    PreviewsRail(
                      movies: state.trendingMovies,
                      onLoadMore: () {
                        context
                            .read<DashboardBloc>()
                            .add(LoadMoreTrendingEvent());
                      },
                      isLoadingMore: state.isTrendingLoadingMore,
                    ),
                    const SizedBox(height: 16),
                    MovieRail(
                      title: 'Trending This Week',
                      movies: state.trendingMovies,
                      onLoadMore: () {
                        context
                            .read<DashboardBloc>()
                            .add(LoadMoreTrendingEvent());
                      },
                      isLoadingMore: state.isTrendingLoadingMore,
                    ),
                    const SizedBox(height: 16),
                    MovieRail(
                      title: 'Popular Movies',
                      movies: state.popularMovies,
                      onLoadMore: () {
                        context
                            .read<DashboardBloc>()
                            .add(LoadMorePopularEvent());
                      },
                      isLoadingMore: state.isPopularLoadingMore,
                    ),
                    const SizedBox(height: 16),
                    MovieRail(
                      title: 'Now Playing',
                      movies: state.nowPlayingMovies,
                      onLoadMore: () {
                        context
                            .read<DashboardBloc>()
                            .add(LoadMoreNowPlayingEvent());
                      },
                      isLoadingMore: state.isNowPlayingLoadingMore,
                    ),
                    const SizedBox(height: 16),
                    MovieRail(
                      title: 'Top Rated',
                      movies: state.topRatedMovies,
                      onLoadMore: () {
                        context
                            .read<DashboardBloc>()
                            .add(LoadMoreTopRatedEvent());
                      },
                      isLoadingMore: state.isTopRatedLoadingMore,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading(
            width: double.infinity,
            height: 350,
            borderRadius: 0,
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ShimmerLoading(width: 160, height: 20, borderRadius: 4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ShimmerLoading(
                    width: 130,
                    height: 190,
                    borderRadius: 12,
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ShimmerLoading(width: 140, height: 20, borderRadius: 4),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: ShimmerLoading(
                    width: 130,
                    height: 190,
                    borderRadius: 12,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
