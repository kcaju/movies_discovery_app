import 'package:equatable/equatable.dart';
import '../../data/models/movie_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final MovieModel? featuredMovie;
  final List<MovieModel> trendingMovies;
  final int trendingPage;
  final bool isTrendingLoadingMore;

  final List<MovieModel> popularMovies;
  final int popularPage;
  final bool isPopularLoadingMore;

  final List<MovieModel> nowPlayingMovies;
  final int nowPlayingPage;
  final bool isNowPlayingLoadingMore;

  final List<MovieModel> topRatedMovies;
  final int topRatedPage;
  final bool isTopRatedLoadingMore;

  const DashboardLoaded({
    this.featuredMovie,
    required this.trendingMovies,
    this.trendingPage = 1,
    this.isTrendingLoadingMore = false,
    required this.popularMovies,
    this.popularPage = 1,
    this.isPopularLoadingMore = false,
    required this.nowPlayingMovies,
    this.nowPlayingPage = 1,
    this.isNowPlayingLoadingMore = false,
    required this.topRatedMovies,
    this.topRatedPage = 1,
    this.isTopRatedLoadingMore = false,
  });

  DashboardLoaded copyWith({
    MovieModel? featuredMovie,
    List<MovieModel>? trendingMovies,
    int? trendingPage,
    bool? isTrendingLoadingMore,
    List<MovieModel>? popularMovies,
    int? popularPage,
    bool? isPopularLoadingMore,
    List<MovieModel>? nowPlayingMovies,
    int? nowPlayingPage,
    bool? isNowPlayingLoadingMore,
    List<MovieModel>? topRatedMovies,
    int? topRatedPage,
    bool? isTopRatedLoadingMore,
  }) {
    return DashboardLoaded(
      featuredMovie: featuredMovie ?? this.featuredMovie,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      trendingPage: trendingPage ?? this.trendingPage,
      isTrendingLoadingMore:
          isTrendingLoadingMore ?? this.isTrendingLoadingMore,
      popularMovies: popularMovies ?? this.popularMovies,
      popularPage: popularPage ?? this.popularPage,
      isPopularLoadingMore: isPopularLoadingMore ?? this.isPopularLoadingMore,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      nowPlayingPage: nowPlayingPage ?? this.nowPlayingPage,
      isNowPlayingLoadingMore:
          isNowPlayingLoadingMore ?? this.isNowPlayingLoadingMore,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      topRatedPage: topRatedPage ?? this.topRatedPage,
      isTopRatedLoadingMore:
          isTopRatedLoadingMore ?? this.isTopRatedLoadingMore,
    );
  }

  @override
  List<Object?> get props => [
        featuredMovie,
        trendingMovies,
        trendingPage,
        isTrendingLoadingMore,
        popularMovies,
        popularPage,
        isPopularLoadingMore,
        nowPlayingMovies,
        nowPlayingPage,
        isNowPlayingLoadingMore,
        topRatedMovies,
        topRatedPage,
        isTopRatedLoadingMore,
      ];
}

class DashboardEmpty extends DashboardState {
  final String message;

  const DashboardEmpty({this.message = 'No movies available at the moment.'});

  @override
  List<Object?> get props => [message];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
