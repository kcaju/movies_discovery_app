import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_client.dart';
import '../../../dashboard/data/models/movie_model.dart';
import '../../../dashboard/data/models/movie_response.dart';

abstract class SearchRemoteDataSource {
  Future<List<MovieModel>> searchMovies(String query, {int page = 1});
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiClient apiClient;

  SearchRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<MovieModel>> searchMovies(String query, {int page = 1}) async {
    final response = await apiClient.get(
      ApiConstants.searchMovie,
      queryParameters: {
        'query': query,
        'page': page,
        'include_adult': false,
      },
    );
    final data = MovieResponse.fromJson(response.data as Map<String, dynamic>);
    return data.results;
  }
}
