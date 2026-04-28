import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/usecases/usecase.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/domain/params/params.dart';
import 'package:notes_app/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class UpdateNoteUsecase implements UseCase<NoteEntity, UpdateNoteParams> {
  final HomeRepository _repository;

  UpdateNoteUsecase(this._repository);

  @override
  Future<Either<Failure, NoteEntity>> call(UpdateNoteParams params) {
    return _repository.updateNote(params);
  }
}
