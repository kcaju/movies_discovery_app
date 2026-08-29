import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../models/movie_model.dart';
import '../models/movie_response.dart';

abstract class DashboardRemoteDataSource {
  Future<List<MovieModel>> getTrending({int page = 1});
  Future<List<MovieModel>> getPopular({int page = 1});
  Future<List<MovieModel>> getNowPlaying({int page = 1});
  Future<List<MovieModel>> getTopRated({int page = 1});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final ApiClient apiClient;

  DashboardRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MovieModel>> getTrending({int page = 1}) async {
    final response = await apiClient.get(
      ApiConstants.trendingAllWeek,
      queryParameters: {'page': page},
    );
    final data = MovieResponse.fromJson(response.data as Map<String, dynamic>);
    return data.results;
  }

  @override
  Future<List<MovieModel>> getPopular({int page = 1}) async {
    final response = await apiClient.get(
      ApiConstants.popularMovies,
      queryParameters: {'page': page},
    );
    final data = MovieResponse.fromJson(response.data as Map<String, dynamic>);
    return data.results;
  }

  @override
  Future<List<MovieModel>> getNowPlaying({int page = 1}) async {
    final response = await apiClient.get(
      ApiConstants.nowPlayingMovies,
      queryParameters: {'page': page},
    );
    final data = MovieResponse.fromJson(response.data as Map<String, dynamic>);
    return data.results;
  }

  @override
  Future<List<MovieModel>> getTopRated({int page = 1}) async {
    final response = await apiClient.get(
      ApiConstants.topRatedMovies,
      queryParameters: {'page': page},
    );
    final data = MovieResponse.fromJson(response.data as Map<String, dynamic>);
    return data.results;
  }
}
