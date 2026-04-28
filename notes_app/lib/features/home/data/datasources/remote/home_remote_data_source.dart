import 'package:dartz/dartz.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';
import 'package:notes_app/features/home/domain/params/params.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, List<NoteModel>>> getNotes();
  Future<Either<Failure, NoteModel>> createNote(PostNoteParams params);
  Future<Either<Failure, NoteModel>> updateNote(UpdateNoteParams params);
  Future<Either<Failure, NoteModel>> getNote(int id);
  Future<Either<Failure, String>> deleteNote(int id);
}
