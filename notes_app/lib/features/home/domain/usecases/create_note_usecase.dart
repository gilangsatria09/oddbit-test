import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/usecases/usecase.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/domain/params/params.dart';
import 'package:notes_app/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class CreateNoteUsecase implements UseCase<NoteEntity, PostNoteParams> {
  final HomeRepository _repository;

  CreateNoteUsecase(this._repository);

  @override
  Future<Either<Failure, NoteEntity>> call(PostNoteParams params) {
    return _repository.createNote(params);
  }
}
