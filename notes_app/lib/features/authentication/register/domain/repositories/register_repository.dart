import 'package:dartz/dartz.dart';
import 'package:notes_app/core/core.dart';

abstract class RegisterRepository {
  Future<Either<Failure, void>> register(Map<String, dynamic> params);
}
