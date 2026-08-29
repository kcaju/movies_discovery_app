import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies_app/features/dashboard/data/models/movie_model.dart';
import 'package:movies_app/features/search/data/repositories/search_repository.dart';
import 'package:movies_app/features/search/presentation/bloc/search_bloc.dart';
import 'package:movies_app/features/search/presentation/bloc/search_event.dart';
import 'package:movies_app/features/search/presentation/bloc/search_state.dart';

class MockSearchRepository extends Mock implements SearchRepository {}

void main() {
  late MockSearchRepository mockRepository;
  late SearchBloc searchBloc;

  final testMovie = MovieModel(
    id: 1,
    title: 'Avatar',
    overview: 'A paraplegic Marine dispatched to the moon Pandora...',
    posterPath: '/avatar.jpg',
    backdropPath: '/avatar_bg.jpg',
    releaseDate: '2009-12-18',
    voteAverage: 7.9,
    voteCount: 28000,
    popularity: 90.0,
  );

  setUp(() {
    mockRepository = MockSearchRepository();
    searchBloc = SearchBloc(repository: mockRepository);
  });

  tearDown(() {
    searchBloc.close();
  });

  test('initial state should be SearchInitial', () {
    expect(searchBloc.state, equals(SearchInitial()));
  });

  blocTest<SearchBloc, SearchState>(
    'emits [SearchLoading, SearchSuccess] when query returns results',
    build: () {
      when(() => mockRepository.searchMovies('Avatar')).thenAnswer((_) async => [testMovie]);
      return searchBloc;
    },
    act: (bloc) => bloc.add(const SearchQueryChangedEvent('Avatar')),
    expect: () => [
      SearchLoading(),
      SearchSuccess(movies: [testMovie], query: 'Avatar'),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'emits [SearchLoading, SearchEmpty] when query returns no results',
    build: () {
      when(() => mockRepository.searchMovies('NonExistentMovie')).thenAnswer((_) async => []);
      return searchBloc;
    },
    act: (bloc) => bloc.add(const SearchQueryChangedEvent('NonExistentMovie')),
    expect: () => [
      SearchLoading(),
      const SearchEmpty(query: 'NonExistentMovie'),
    ],
  );

  blocTest<SearchBloc, SearchState>(
    'emits [SearchInitial] when query is empty or cleared',
    build: () => searchBloc,
    act: (bloc) => bloc.add(const SearchQueryChangedEvent('   ')),
    expect: () => [
      SearchInitial(),
    ],
  );
}
