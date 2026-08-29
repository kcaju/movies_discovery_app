import '../../../dashboard/data/models/movie_model.dart';
import '../datasources/search_remote_data_source.dart';

abstract class SearchRepository {
  Future<List<MovieModel>> searchMovies(String query, {int page = 1});
}

class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) {
    return remoteDataSource.searchMovies(query, page: page);
  }
}
