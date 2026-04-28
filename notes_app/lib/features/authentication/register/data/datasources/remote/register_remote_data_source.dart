import 'package:dartz/dartz.dart';
import 'package:notes_app/core/core.dart';

abstract class RegisterRemoteDataSource {
  Future<Either<Failure, void>> register(Map<String, dynamic> params);
}
