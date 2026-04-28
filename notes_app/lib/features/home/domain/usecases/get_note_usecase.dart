import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/usecases/usecase.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetNoteUsecase implements UseCase<NoteEntity, int> {
  final HomeRepository _repository;

  GetNoteUsecase(this._repository);

  @override
  Future<Either<Failure, NoteEntity>> call(int params) {
    return _repository.getNote(params);
  }
}
