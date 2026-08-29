import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../dashboard/data/models/movie_model.dart';
import '../../../dashboard/data/models/movie_response.dart';

abstract class ComingSoonRemoteDataSource {
  Future<List<MovieModel>> getUpcomingMovies({int page = 1});
}

class ComingSoonRemoteDataSourceImpl implements ComingSoonRemoteDataSource {
  final ApiClient apiClient;

  ComingSoonRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MovieModel>> getUpcomingMovies({int page = 1}) async {
    final response = await apiClient.get(
      ApiConstants.upcomingMovies,
      queryParameters: {'page': page},
    );
    final data = MovieResponse.fromJson(response.data as Map<String, dynamic>);
    return data.results;
  }
}
