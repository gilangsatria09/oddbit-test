import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';

import 'register_remote_data_source.dart';

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final AuthHttpClient _authHttpClient;

  RegisterRemoteDataSourceImpl(this._authHttpClient);

  @override
  Future<Either<Failure, void>> register(Map<String, dynamic> params) async {
    final request = await _authHttpClient.register(params);
    return request.fold((l) => Left(l), (r) => Right(null));
  }
}
