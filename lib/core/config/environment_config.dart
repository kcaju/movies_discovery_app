import 'env_keys.dart';

class EnvironmentConfig {
  static const String _envApiKey = String.fromEnvironment('TMDB_API_KEY');
  static const String _envAccessToken = String.fromEnvironment('TMDB_ACCESS_TOKEN');

  static String get tmdbApiKey {
    if (_envApiKey.isNotEmpty) return _envApiKey;
    return EnvKeys.tmdbApiKey;
  }

  static String get tmdbAccessToken {
    if (_envAccessToken.isNotEmpty) return _envAccessToken;
    return EnvKeys.tmdbAccessToken;
  }

  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrlW500 = 'https://image.tmdb.org/t/p/w500';
  static const String imageBaseUrlOriginal = 'https://image.tmdb.org/t/p/original';
  static const String imageBaseUrlW780 = 'https://image.tmdb.org/t/p/w780';
}
