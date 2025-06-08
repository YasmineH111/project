import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String errorMessage;

  ServerException({required this.errorMessage});
  @override
  String toString() => 'ServerException: $errorMessage';
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errorMessage: e.response!.data);
    case DioExceptionType.sendTimeout:
      throw ServerException(errorMessage: e.response!.data);
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorMessage: e.response!.data);
    case DioExceptionType.badCertificate:
      throw ServerException(errorMessage: e.response!.data);
    case DioExceptionType.cancel:
      throw ServerException(errorMessage: e.response!.data);
    case DioExceptionType.connectionError:
      throw ServerException(errorMessage: e.response!.data);
    case DioExceptionType.unknown:
      throw ServerException(errorMessage: e.response!.data);
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerException(errorMessage: e.response!.data);
        case 401:
        case 403:
          throw ServerException(errorMessage: e.response!.data);
        case 404:
          throw ServerException(errorMessage: e.response!.data);
        case 500:
          throw ServerException(errorMessage: e.response!.data);
        case 502:
        case 503:
        case 504:
          throw ServerException(errorMessage: e.response!.data);
        default:
          throw ServerException(errorMessage: e.response!.data);
      }
  }
}
