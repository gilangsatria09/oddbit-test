import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/errors/failure.dart';
import 'package:notes_app/features/authentication/register/data/datasources/remote/register_remote_data_source.dart';
import 'package:notes_app/features/authentication/register/domain/repositories/register_repository.dart';

@LazySingleton(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDataSource _registerRemoteDataSource;

  RegisterRepositoryImpl(this._registerRemoteDataSource);

  @override
  Future<Either<Failure, void>> register(Map<String, dynamic> params) {
    return _registerRemoteDataSource.register(params);
  }
}
