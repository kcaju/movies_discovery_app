import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_view.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/shimmer_loading.dart';
import '../bloc/search_bloc.dart';
import '../bloc/search_event.dart';
import '../bloc/search_state.dart';
import '../widgets/search_bar_widget.dart';
import '../widgets/search_movie_card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: 20),
            SearchBarWidget(
              onQueryChanged: (query) {
                context.read<SearchBloc>().add(SearchQueryChangedEvent(query));
              },
              onClear: () {
                context.read<SearchBloc>().add(ClearSearchEvent());
              },
            ),
            Expanded(
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return const EmptyView(
                      icon: Icons.search_rounded,
                      title: 'Find Any Movie',
                      message:
                          'Type a title, actor, or genre to explore TMDB movies in real-time.',
                    );
                  } else if (state is SearchLoading) {
                    return _buildLoadingShimmer();
                  } else if (state is SearchError) {
                    return ErrorView(
                      message: state.message,
                      onRetry: () {
                        context.read<SearchBloc>().add(
                          SearchQueryChangedEvent(state.query),
                        );
                      },
                    );
                  } else if (state is SearchEmpty) {
                    return EmptyView(
                      icon: Icons.search_off_rounded,
                      title: 'No Results Found',
                      message:
                          'We couldn\'t find any movies matching "${state.query}". Try another query.',
                    );
                  } else if (state is SearchSuccess) {
                    return ListView.separated(
                      padding: const EdgeInsets.all(16.0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: state.movies.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return SearchMovieCard(movie: state.movies[index]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Row(
            children: [
              ShimmerLoading(width: 80, height: 115, borderRadius: 8),
              SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerLoading(
                      width: double.infinity,
                      height: 18,
                      borderRadius: 4,
                    ),
                    SizedBox(height: 8),
                    ShimmerLoading(width: 80, height: 14, borderRadius: 4),
                    SizedBox(height: 12),
                    ShimmerLoading(
                      width: double.infinity,
                      height: 14,
                      borderRadius: 4,
                    ),
                    SizedBox(height: 6),
                    ShimmerLoading(width: 150, height: 14, borderRadius: 4),
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
