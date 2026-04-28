import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/core/usecases/usecase.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetNotesUsecase implements UseCase<List<NoteEntity>, void> {
  final HomeRepository _repository;

  GetNotesUsecase(this._repository);

  @override
  Future<Either<Failure, List<NoteEntity>>> call(void params) {
    return _repository.getNotes();
  }
}
