import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/errors/failure.dart';
import 'package:notes_app/core/storage/storage_service.dart';
import 'package:notes_app/features/authentication/login/data/datasources/remote/login_remote_data_source.dart';
import 'package:notes_app/features/authentication/login/domain/repositories/login_repository.dart';

@LazySingleton(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource _remoteDataSource;
  final StorageService _storageService;

  LoginRepositoryImpl(this._remoteDataSource, this._storageService);

  @override
  Future<Either<Failure, String>> login(Map<String, dynamic> data) async {
    final result = await _remoteDataSource.login(data);
    return result.fold((l) => Left(l), (r) async {
      await _storageService.writeSecureToken(r);
      return Right(r);
    });
  }
}
