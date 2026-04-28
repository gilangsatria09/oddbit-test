import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/usecases/usecase.dart';
import 'package:notes_app/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class DeleteNoteUsecase implements UseCase<String, int> {
  final HomeRepository _repository;

  DeleteNoteUsecase(this._repository);

  @override
  Future<Either<Failure, String>> call(int params) {
    return _repository.deleteNote(params);
  }
}
