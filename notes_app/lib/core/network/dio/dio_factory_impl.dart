import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/network/dio/dio_factory.dart';
import 'package:notes_app/core/network/dio/interceptors/auth_interceptor.dart';
import 'package:notes_app/core/storage/storage_service.dart';

@LazySingleton(as: DioFactory)
class DioFactoryImpl implements DioFactory {
  final StorageService _storageService;

  DioFactoryImpl(this._storageService);

  @override
  Dio create({required String subPath}) {
    final dio = Dio(
      BaseOptions(
        baseUrl:
            '${const String.fromEnvironment('BASE_URL', defaultValue: 'http://localhost:8080')}/api/$subPath/',
        connectTimeout: const Duration(seconds: 25),
        receiveTimeout: const Duration(seconds: 25),
      ),
    );

    dio.interceptors.add(
      HttpFormatter(
        loggingFilter: (request, response, error) => true,
        includeRequest: true,
        includeRequestHeaders: true,
      ),
    );
    dio.interceptors.add(AuthInterceptor(_storageService));

    return dio;
  }
}
