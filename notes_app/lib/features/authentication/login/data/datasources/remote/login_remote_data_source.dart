import 'package:dartz/dartz.dart';
import 'package:notes_app/core/core.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, String>> login(Map<String, dynamic> data);
}
