import '../datasources/dashboard_remote_data_source.dart';
import '../models/movie_model.dart';

abstract class DashboardRepository {
  Future<List<MovieModel>> getTrending({int page = 1});
  Future<List<MovieModel>> getPopular({int page = 1});
  Future<List<MovieModel>> getNowPlaying({int page = 1});
  Future<List<MovieModel>> getTopRated({int page = 1});
}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieModel>> getTrending({int page = 1}) =>
      remoteDataSource.getTrending(page: page);

  @override
  Future<List<MovieModel>> getPopular({int page = 1}) =>
      remoteDataSource.getPopular(page: page);

  @override
  Future<List<MovieModel>> getNowPlaying({int page = 1}) =>
      remoteDataSource.getNowPlaying(page: page);

  @override
  Future<List<MovieModel>> getTopRated({int page = 1}) =>
      remoteDataSource.getTopRated(page: page);
}
