import 'package:equatable/equatable.dart';
import 'movie_model.dart';

class MovieResponse extends Equatable {
  final int page;
  final List<MovieModel> results;
  final int totalPages;
  final int totalResults;

  const MovieResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'] as List<dynamic>? ?? [];
    return MovieResponse(
      page: json['page'] as int? ?? 1,
      results: rawResults
          .whereType<Map<String, dynamic>>()
          .map((m) => MovieModel.fromJson(m))
          .toList(),
      totalPages: json['total_pages'] as int? ?? 1,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results.map((m) => m.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }

  @override
  List<Object?> get props => [page, results, totalPages, totalResults];
}
