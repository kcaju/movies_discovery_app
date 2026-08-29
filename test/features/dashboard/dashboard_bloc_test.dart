import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/dashboard/data/models/movie_model.dart';
import 'package:movies_app/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:movies_app/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:movies_app/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:movies_app/features/dashboard/presentation/bloc/dashboard_state.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

void main() {
  late MockDashboardRepository mockRepository;
  late DashboardBloc dashboardBloc;

  final testMovie1 = MovieModel(
    id: 1,
    title: 'Inception',
    overview: 'A thief who steals corporate secrets...',
    posterPath: '/path.jpg',
    backdropPath: '/back.jpg',
    releaseDate: '2010-07-16',
    voteAverage: 8.8,
    voteCount: 30000,
    popularity: 100.0,
  );

  final testMovie2 = MovieModel(
    id: 2,
    title: 'Interstellar',
    overview: 'A team of explorers travel through a wormhole...',
    posterPath: '/path2.jpg',
    backdropPath: '/back2.jpg',
    releaseDate: '2014-11-07',
    voteAverage: 8.7,
    voteCount: 32000,
    popularity: 120.0,
  );

  setUp(() {
    mockRepository = MockDashboardRepository();
    dashboardBloc = DashboardBloc(repository: mockRepository);
  });

  tearDown(() {
    dashboardBloc.close();
  });

  test('initial state should be DashboardInitial', () {
    expect(dashboardBloc.state, equals(DashboardInitial()));
  });

  blocTest<DashboardBloc, DashboardState>(
    'emits [DashboardLoading, DashboardLoaded] when FetchDashboardDataEvent is successful',
    build: () {
      when(() => mockRepository.getTrending(page: any(named: 'page')))
          .thenAnswer((_) async => [testMovie1]);
      when(() => mockRepository.getPopular(page: any(named: 'page')))
          .thenAnswer((_) async => [testMovie1]);
      when(() => mockRepository.getNowPlaying(page: any(named: 'page')))
          .thenAnswer((_) async => [testMovie1]);
      when(() => mockRepository.getTopRated(page: any(named: 'page')))
          .thenAnswer((_) async => [testMovie1]);
      return dashboardBloc;
    },
    act: (bloc) => bloc.add(const FetchDashboardDataEvent()),
    expect: () => [
      DashboardLoading(),
      DashboardLoaded(
        featuredMovie: testMovie1,
        trendingMovies: [testMovie1],
        popularMovies: [testMovie1],
        nowPlayingMovies: [testMovie1],
        topRatedMovies: [testMovie1],
      ),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits [DashboardLoading, DashboardError] when repository throws an exception',
    build: () {
      when(() => mockRepository.getTrending(page: any(named: 'page')))
          .thenThrow(Exception('Server error'));
      when(() => mockRepository.getPopular(page: any(named: 'page')))
          .thenAnswer((_) async => []);
      when(() => mockRepository.getNowPlaying(page: any(named: 'page')))
          .thenAnswer((_) async => []);
      when(() => mockRepository.getTopRated(page: any(named: 'page')))
          .thenAnswer((_) async => []);
      return dashboardBloc;
    },
    act: (bloc) => bloc.add(const FetchDashboardDataEvent()),
    expect: () => [
      DashboardLoading(),
      const DashboardError(message: 'Exception: Server error'),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'appends new movies and increments page when LoadMoreTrendingEvent is added',
    seed: () => DashboardLoaded(
      featuredMovie: testMovie1,
      trendingMovies: [testMovie1],
      trendingPage: 1,
      popularMovies: [testMovie1],
      nowPlayingMovies: [testMovie1],
      topRatedMovies: [testMovie1],
    ),
    build: () {
      when(() => mockRepository.getTrending(page: 2))
          .thenAnswer((_) async => [testMovie2]);
      return dashboardBloc;
    },
    act: (bloc) => bloc.add(LoadMoreTrendingEvent()),
    expect: () => [
      DashboardLoaded(
        featuredMovie: testMovie1,
        trendingMovies: [testMovie1],
        trendingPage: 1,
        isTrendingLoadingMore: true,
        popularMovies: [testMovie1],
        nowPlayingMovies: [testMovie1],
        topRatedMovies: [testMovie1],
      ),
      DashboardLoaded(
        featuredMovie: testMovie1,
        trendingMovies: [testMovie1, testMovie2],
        trendingPage: 2,
        isTrendingLoadingMore: false,
        popularMovies: [testMovie1],
        nowPlayingMovies: [testMovie1],
        topRatedMovies: [testMovie1],
      ),
    ],
  );
}
