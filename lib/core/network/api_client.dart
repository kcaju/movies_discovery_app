import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config/environment_config.dart';
import '../constants/app_constants.dart';
import 'api_exceptions.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({Dio? customDio}) {
    dio = customDio ??
        Dio(
          BaseOptions(
            baseUrl: EnvironmentConfig.tmdbBaseUrl,
            connectTimeout: AppConstants.connectTimeout,
            receiveTimeout: AppConstants.receiveTimeout,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.clear();

    // 1. Auth Interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final queryParams = Map<String, dynamic>.from(options.queryParameters);
          final apiKey = EnvironmentConfig.tmdbApiKey;
          if (apiKey.isNotEmpty && !queryParams.containsKey('api_key')) {
            queryParams['api_key'] = apiKey;
            options.queryParameters = queryParams;
          }

          final token = EnvironmentConfig.tmdbAccessToken;
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );

    // 2. Logging Interceptor (in debug mode)
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestHeader: false,
          requestBody: true,
          responseBody: false,
          responseHeader: false,
          error: true,
          logPrint: (obj) => debugPrint('[DIO] $obj'),
        ),
      );
    }
  }

  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      throw ApiExceptionHandler.handleDioException(e);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
