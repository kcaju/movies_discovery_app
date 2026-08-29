import 'package:dio/dio.dart';

abstract class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException(this.message, [this.statusCode]);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection or network timeout. Please check your connection.']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'A server error occurred. Please try again later.', super.statusCode]);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException([String message = 'Invalid API Key or unauthorized access.'])
      : super(message, 401);
}

class NotFoundException extends AppException {
  const NotFoundException([String message = 'The requested resource was not found.'])
      : super(message, 404);
}

class UnknownException extends AppException {
  const UnknownException([super.message = 'An unexpected error occurred. Please try again.']);
}

class ApiExceptionHandler {
  static AppException handleDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final statusMessage = error.response?.data is Map<String, dynamic>
            ? (error.response?.data['status_message'] as String?)
            : null;

        if (statusCode == 401) {
          return UnauthorizedException(statusMessage ?? 'Unauthorized: check your TMDB API credentials.');
        } else if (statusCode == 404) {
          return NotFoundException(statusMessage ?? 'Resource not found.');
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException(statusMessage ?? 'Server error occurred.', statusCode);
        } else {
          return ServerException(statusMessage ?? 'Request failed with status $statusCode', statusCode);
        }

      case DioExceptionType.cancel:
        return const UnknownException('Request was cancelled.');

      case DioExceptionType.badCertificate:
        return const NetworkException('Security certificate verification failed.');

      case DioExceptionType.unknown:
      default:
        return const UnknownException();
    }
  }
}
