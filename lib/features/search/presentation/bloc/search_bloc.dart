import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/search_repository.dart';
import 'search_event.dart';
import 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  SearchBloc({required this.repository}) : super(SearchInitial()) {
    on<SearchQueryChangedEvent>(_onSearchQueryChanged);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchQueryChanged(
    SearchQueryChangedEvent event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    try {
      final results = await repository.searchMovies(query);
      if (results.isEmpty) {
        emit(SearchEmpty(query: query));
      } else {
        emit(SearchSuccess(movies: results, query: query));
      }
    } catch (e) {
      emit(SearchError(message: e.toString(), query: query));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }
}
