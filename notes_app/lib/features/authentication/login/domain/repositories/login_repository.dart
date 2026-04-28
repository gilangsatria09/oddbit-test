import 'package:dartz/dartz.dart';
import 'package:notes_app/core/core.dart';

abstract class LoginRepository {
  Future<Either<Failure, String>> login(Map<String, dynamic> data);
}
