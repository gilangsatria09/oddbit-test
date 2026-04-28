import 'package:dio/dio.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/errors/failure.dart';

Failure handleDioError(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionError:
      return Failure.connection('No Internet connection!');
    case DioExceptionType.connectionTimeout ||
        DioExceptionType.sendTimeout ||
        DioExceptionType.receiveTimeout:
      return Failure.timeout('Connection timeout!');
    case DioExceptionType.badResponse:
      if (e.response?.statusCode == 401) {
        return Failure.unauthenticated(
          e.response?.data['message'] ?? 'Unauthenticated!',
        );
      }
      return Failure.server(
        statusCode: e.response?.data['statusCode'],
        message: e.response?.data['message'],
      );
    case DioExceptionType.unknown:
      return Failure.unexpected('Unexpected Error!');
    default:
      return Failure.unexpected('Unexpected Error!');
  }
}
