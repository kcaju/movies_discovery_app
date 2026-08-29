import '../../../dashboard/data/models/movie_model.dart';
import '../datasources/coming_soon_remote_data_source.dart';

abstract class ComingSoonRepository {
  Future<List<MovieModel>> getUpcomingMovies({int page = 1});
}

class ComingSoonRepositoryImpl implements ComingSoonRepository {
  final ComingSoonRemoteDataSource remoteDataSource;

  ComingSoonRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieModel>> getUpcomingMovies({int page = 1}) {
    return remoteDataSource.getUpcomingMovies(page: page);
  }
}
