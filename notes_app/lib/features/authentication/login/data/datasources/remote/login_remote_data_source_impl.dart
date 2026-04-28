import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/authentication/login/data/datasources/remote/login_remote_data_source.dart';

@LazySingleton(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final AuthHttpClient _authHttpClient;

  LoginRemoteDataSourceImpl(this._authHttpClient);

  @override
  Future<Either<Failure, String>> login(Map<String, dynamic> data) async {
    final response = await _authHttpClient.login(data);
    return response.fold((l) => Left(l), (r) => Right(r['data']['token']));
  }
}
