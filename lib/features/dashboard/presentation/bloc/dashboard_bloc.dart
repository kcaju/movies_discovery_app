import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/dashboard_repository.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final DashboardRepository repository;

  DashboardBloc({required this.repository}) : super(DashboardInitial()) {
    on<FetchDashboardDataEvent>(_onFetchDashboardData);
    on<LoadMoreTrendingEvent>(_onLoadMoreTrending);
    on<LoadMorePopularEvent>(_onLoadMorePopular);
    on<LoadMoreNowPlayingEvent>(_onLoadMoreNowPlaying);
    on<LoadMoreTopRatedEvent>(_onLoadMoreTopRated);
  }

  Future<void> _onFetchDashboardData(
    FetchDashboardDataEvent event,
    Emitter<DashboardState> emit,
  ) async {
    if (!event.isRefresh) {
      emit(DashboardLoading());
    }

    try {
      final results = await Future.wait([
        repository.getTrending(page: 1),
        repository.getPopular(page: 1),
        repository.getNowPlaying(page: 1),
        repository.getTopRated(page: 1),
      ]);

      final trending = results[0];
      final popular = results[1];
      final nowPlaying = results[2];
      final topRated = results[3];

      if (trending.isEmpty && popular.isEmpty && nowPlaying.isEmpty && topRated.isEmpty) {
        emit(const DashboardEmpty());
        return;
      }

      final featured = trending.isNotEmpty
          ? trending.first
          : (popular.isNotEmpty ? popular.first : null);

      emit(
        DashboardLoaded(
          featuredMovie: featured,
          trendingMovies: trending,
          trendingPage: 1,
          popularMovies: popular,
          popularPage: 1,
          nowPlayingMovies: nowPlaying,
          nowPlayingPage: 1,
          topRatedMovies: topRated,
          topRatedPage: 1,
        ),
      );
    } catch (e) {
      emit(DashboardError(message: e.toString()));
    }
  }

  Future<void> _onLoadMoreTrending(
    LoadMoreTrendingEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! DashboardLoaded || currentState.isTrendingLoadingMore) return;

    emit(currentState.copyWith(isTrendingLoadingMore: true));

    try {
      final nextPage = currentState.trendingPage + 1;
      final newMovies = await repository.getTrending(page: nextPage);
      if (newMovies.isNotEmpty) {
        final existingIds = currentState.trendingMovies.map((m) => m.id).toSet();
        final filteredNew = newMovies.where((m) => !existingIds.contains(m.id)).toList();

        emit(currentState.copyWith(
          trendingMovies: [...currentState.trendingMovies, ...filteredNew],
          trendingPage: nextPage,
          isTrendingLoadingMore: false,
        ));
      } else {
        emit(currentState.copyWith(isTrendingLoadingMore: false));
      }
    } catch (_) {
      emit(currentState.copyWith(isTrendingLoadingMore: false));
    }
  }

  Future<void> _onLoadMorePopular(
    LoadMorePopularEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! DashboardLoaded || currentState.isPopularLoadingMore) return;

    emit(currentState.copyWith(isPopularLoadingMore: true));

    try {
      final nextPage = currentState.popularPage + 1;
      final newMovies = await repository.getPopular(page: nextPage);
      if (newMovies.isNotEmpty) {
        final existingIds = currentState.popularMovies.map((m) => m.id).toSet();
        final filteredNew = newMovies.where((m) => !existingIds.contains(m.id)).toList();

        emit(currentState.copyWith(
          popularMovies: [...currentState.popularMovies, ...filteredNew],
          popularPage: nextPage,
          isPopularLoadingMore: false,
        ));
      } else {
        emit(currentState.copyWith(isPopularLoadingMore: false));
      }
    } catch (_) {
      emit(currentState.copyWith(isPopularLoadingMore: false));
    }
  }

  Future<void> _onLoadMoreNowPlaying(
    LoadMoreNowPlayingEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! DashboardLoaded || currentState.isNowPlayingLoadingMore) return;

    emit(currentState.copyWith(isNowPlayingLoadingMore: true));

    try {
      final nextPage = currentState.nowPlayingPage + 1;
      final newMovies = await repository.getNowPlaying(page: nextPage);
      if (newMovies.isNotEmpty) {
        final existingIds = currentState.nowPlayingMovies.map((m) => m.id).toSet();
        final filteredNew = newMovies.where((m) => !existingIds.contains(m.id)).toList();

        emit(currentState.copyWith(
          nowPlayingMovies: [...currentState.nowPlayingMovies, ...filteredNew],
          nowPlayingPage: nextPage,
          isNowPlayingLoadingMore: false,
        ));
      } else {
        emit(currentState.copyWith(isNowPlayingLoadingMore: false));
      }
    } catch (_) {
      emit(currentState.copyWith(isNowPlayingLoadingMore: false));
    }
  }

  Future<void> _onLoadMoreTopRated(
    LoadMoreTopRatedEvent event,
    Emitter<DashboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is! DashboardLoaded || currentState.isTopRatedLoadingMore) return;

    emit(currentState.copyWith(isTopRatedLoadingMore: true));

    try {
      final nextPage = currentState.topRatedPage + 1;
      final newMovies = await repository.getTopRated(page: nextPage);
      if (newMovies.isNotEmpty) {
        final existingIds = currentState.topRatedMovies.map((m) => m.id).toSet();
        final filteredNew = newMovies.where((m) => !existingIds.contains(m.id)).toList();

        emit(currentState.copyWith(
          topRatedMovies: [...currentState.topRatedMovies, ...filteredNew],
          topRatedPage: nextPage,
          isTopRatedLoadingMore: false,
        ));
      } else {
        emit(currentState.copyWith(isTopRatedLoadingMore: false));
      }
    } catch (_) {
      emit(currentState.copyWith(isTopRatedLoadingMore: false));
    }
  }
}
