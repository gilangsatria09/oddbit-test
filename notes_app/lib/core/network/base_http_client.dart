import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:notes_app/core/core.dart';

abstract class BaseHttpClient {
  final Dio _dio;

  BaseHttpClient(this._dio);

  @protected
  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParams,
        options: options,
        cancelToken: cancelToken,
      );
      return Right(response.data as T);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (_) {
      return Left(UnexpectedFailure('Unexpected Error!'));
    }
  }

  @protected
  Future<Either<Failure, T>> post<T>(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.post<T>(path, data: data, options: options);
      return Right(response.data as T);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (_) {
      return Left(UnexpectedFailure('Unexpected Error!'));
    }
  }

  @protected
  Future<Either<Failure, T>> put<T>(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.put<T>(path, data: data, options: options);
      return Right(response.data as T);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (_) {
      return Left(UnexpectedFailure('Unexpected Error!'));
    }
  }

  @protected
  Future<Either<Failure, T>> delete<T>(
    String path, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete<T>(path, data: data, options: options);
      return Right(response.data as T);
    } on DioException catch (e) {
      return Left(handleDioError(e));
    } catch (_) {
      return Left(UnexpectedFailure('Unexpected Error!'));
    }
  }
}
