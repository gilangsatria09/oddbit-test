import 'package:dio/dio.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/storage/storage_service.dart';

class AuthInterceptor extends Interceptor {
  final StorageService _storageService;

  AuthInterceptor(this._storageService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final unprotectedPaths = [
      AuthHttpClient.loginPath,
      AuthHttpClient.registerPath,
    ];

    if (unprotectedPaths.contains(options.path)) {
      return super.onRequest(options, handler);
    }

    final token = await _storageService.readSecureToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
