import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/errors/failure.dart';
import 'package:notes_app/core/usecases/usecase.dart';
import 'package:notes_app/features/authentication/login/domain/params/login_params.dart';
import 'package:notes_app/features/authentication/login/domain/repositories/login_repository.dart';

@lazySingleton
class LoginUsecase extends UseCase<String, LoginParams> {
  final LoginRepository _loginRepository;

  LoginUsecase(this._loginRepository);

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return _loginRepository.login(params.toJson());
  }
}
