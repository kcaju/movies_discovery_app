import 'package:equatable/equatable.dart';
import '../../../../core/config/environment_config.dart';

class MovieModel extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final String? releaseDate;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final List<int> genreIds;

  const MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.genreIds = const [],
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? json['name'] as String? ?? 'Untitled',
      overview: json['overview'] as String? ?? '',
      posterPath: json['poster_path'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      releaseDate: json['release_date'] as String? ?? json['first_air_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] as int? ?? 0,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      genreIds: (json['genre_ids'] as List<dynamic>?)
              ?.map((e) => e as int)
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'popularity': popularity,
      'genre_ids': genreIds,
    };
  }

  String? get fullPosterUrl =>
      posterPath != null ? '${EnvironmentConfig.imageBaseUrlW500}$posterPath' : null;

  String? get fullBackdropUrl =>
      backdropPath != null ? '${EnvironmentConfig.imageBaseUrlW780}$backdropPath' : null;

  String get releaseYear {
    if (releaseDate == null || releaseDate!.isEmpty) return '';
    final parts = releaseDate!.split('-');
    return parts.isNotEmpty ? parts[0] : '';
  }

  String get formattedRating => voteAverage.toStringAsFixed(1);

  @override
  List<Object?> get props => [
        id,
        title,
        overview,
        posterPath,
        backdropPath,
        releaseDate,
        voteAverage,
        voteCount,
        popularity,
        genreIds,
      ];
}
