import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';

@lazySingleton
class AuthHttpClient extends BaseHttpClient {
  AuthHttpClient(@Named(ClientModuleName.auth) super.dio);

  static const String loginPath = 'login';
  static const String registerPath = 'register';

  Future<Either<Failure, dynamic>> login(Map<String, dynamic> body) =>
      post(loginPath, data: body);
  Future<Either<Failure, dynamic>> register(Map<String, dynamic> body) =>
      post(registerPath, data: body);
}
