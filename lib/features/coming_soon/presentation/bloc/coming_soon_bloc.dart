import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/coming_soon_repository.dart';
import 'coming_soon_event.dart';
import 'coming_soon_state.dart';

class ComingSoonBloc extends Bloc<ComingSoonEvent, ComingSoonState> {
  final ComingSoonRepository repository;

  ComingSoonBloc({required this.repository}) : super(ComingSoonInitial()) {
    on<FetchComingSoonMoviesEvent>(_onFetchComingSoonMovies);
  }

  Future<void> _onFetchComingSoonMovies(
    FetchComingSoonMoviesEvent event,
    Emitter<ComingSoonState> emit,
  ) async {
    if (!event.isRefresh) {
      emit(ComingSoonLoading());
    }

    try {
      final movies = await repository.getUpcomingMovies();
      if (movies.isEmpty) {
        emit(const ComingSoonEmpty());
      } else {
        emit(ComingSoonLoaded(movies: movies));
      }
    } catch (e) {
      emit(ComingSoonError(message: e.toString()));
    }
  }
}
