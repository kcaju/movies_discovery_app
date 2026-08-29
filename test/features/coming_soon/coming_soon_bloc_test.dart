import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/coming_soon/data/repositories/coming_soon_repository.dart';
import 'package:movies_app/features/coming_soon/presentation/bloc/coming_soon_bloc.dart';
import 'package:movies_app/features/coming_soon/presentation/bloc/coming_soon_event.dart';
import 'package:movies_app/features/coming_soon/presentation/bloc/coming_soon_state.dart';
import 'package:movies_app/features/dashboard/data/models/movie_model.dart';

class MockComingSoonRepository extends Mock implements ComingSoonRepository {}

void main() {
  late MockComingSoonRepository mockRepository;
  late ComingSoonBloc comingSoonBloc;

  final testMovie = MovieModel(
    id: 1,
    title: 'Upcoming Blockbuster',
    overview: 'Coming to theaters next summer...',
    posterPath: '/upcoming.jpg',
    backdropPath: '/upcoming_bg.jpg',
    releaseDate: '2027-05-15',
    voteAverage: 0.0,
    voteCount: 0,
    popularity: 50.0,
  );

  setUp(() {
    mockRepository = MockComingSoonRepository();
    comingSoonBloc = ComingSoonBloc(repository: mockRepository);
  });

  tearDown(() {
    comingSoonBloc.close();
  });

  test('initial state should be ComingSoonInitial', () {
    expect(comingSoonBloc.state, equals(ComingSoonInitial()));
  });

  blocTest<ComingSoonBloc, ComingSoonState>(
    'emits [ComingSoonLoading, ComingSoonLoaded] on FetchComingSoonMoviesEvent success',
    build: () {
      when(() => mockRepository.getUpcomingMovies()).thenAnswer((_) async => [testMovie]);
      return comingSoonBloc;
    },
    act: (bloc) => bloc.add(const FetchComingSoonMoviesEvent()),
    expect: () => [
      ComingSoonLoading(),
      ComingSoonLoaded(movies: [testMovie]),
    ],
  );

  blocTest<ComingSoonBloc, ComingSoonState>(
    'emits [ComingSoonLoading, ComingSoonEmpty] when no upcoming movies returned',
    build: () {
      when(() => mockRepository.getUpcomingMovies()).thenAnswer((_) async => []);
      return comingSoonBloc;
    },
    act: (bloc) => bloc.add(const FetchComingSoonMoviesEvent()),
    expect: () => [
      ComingSoonLoading(),
      const ComingSoonEmpty(),
    ],
  );
}
