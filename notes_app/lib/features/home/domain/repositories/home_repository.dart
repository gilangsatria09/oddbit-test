import 'package:dartz/dartz.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/domain/params/params.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<NoteEntity>>> getNotes();
  Future<Either<Failure, NoteEntity>> createNote(PostNoteParams params);
  Future<Either<Failure, NoteEntity>> updateNote(UpdateNoteParams params);
  Future<Either<Failure, NoteEntity>> getNote(int id);
  Future<Either<Failure, String>> deleteNote(int id);
}
