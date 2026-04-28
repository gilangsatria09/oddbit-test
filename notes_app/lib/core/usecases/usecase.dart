import 'package:dartz/dartz.dart';
import 'package:notes_app/core/errors/failure.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class DynamicUseCase<T, Params> {
  call(Params params);
}
