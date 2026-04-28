import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/errors/failure.dart';
import 'package:notes_app/core/usecases/usecase.dart';
import 'package:notes_app/features/authentication/register/domain/params/params.dart';
import 'package:notes_app/features/authentication/register/domain/repositories/register_repository.dart';

@lazySingleton
class RegisterUsecase extends UseCase<void, RegisterParams> {
  final RegisterRepository _repository;

  RegisterUsecase(this._repository);

  @override
  Future<Either<Failure, void>> call(RegisterParams params) {
    return _repository.register(params.toJson());
  }
}
