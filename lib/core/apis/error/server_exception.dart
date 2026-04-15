import 'package:dio/dio.dart';
import 'package:mobile_app/core/apis/error/failure.dart';


class ServerException implements Exception {
  final Failure failure;

  ServerException({required this.failure});
}

ServerException handleDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(failure: Failure.fromJson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(failure: Failure.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(failure: Failure.fromJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(failure: Failure.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(failure: Failure.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(failure: Failure.fromJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(failure: Failure.fromJson(e.response!.data));

    case DioExceptionType.badResponse:
      switch (e.response!.statusCode) {
        case 400:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
        case 401:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
        case 403:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
        case 404:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
        case 409:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
        case 422:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
        case 504:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
        default:
          throw ServerException(
              failure: Failure.fromJson(e.response!.data));
      }
  }
}
