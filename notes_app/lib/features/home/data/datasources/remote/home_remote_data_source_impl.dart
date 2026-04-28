import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';
import 'package:notes_app/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:notes_app/features/home/data/models/note_model.dart';
import 'package:notes_app/features/home/domain/params/params.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final NotesHttpClient _notesHttpClient;

  HomeRemoteDataSourceImpl(this._notesHttpClient);

  @override
  Future<Either<Failure, NoteModel>> createNote(PostNoteParams params) async {
    final request = await _notesHttpClient.postNote(params.toJson());
    return request.fold(
      (l) => Left(l),
      (r) => Right(
        BaseResponse.fromJson(r, (json) => NoteModel.fromJson(json)).data!,
      ),
    );
  }

  @override
  Future<Either<Failure, String>> deleteNote(int id) async {
    final request = await _notesHttpClient.deleteNote(id);
    return request.fold(
      (l) => Left(l),
      (r) => Right(
        BaseResponse.fromJson(r, (json) => NoteModel.fromJson(json)).message!,
      ),
    );
  }

  @override
  Future<Either<Failure, List<NoteModel>>> getNotes() async {
    final request = await _notesHttpClient.getNotes();
    return request.fold(
      (l) => Left(l),
      (r) => Right(
        BaseResponse.listFromJson(r, (json) => NoteModel.fromJson(json)).data!,
      ),
    );
  }

  @override
  Future<Either<Failure, NoteModel>> updateNote(UpdateNoteParams params) async {
    final request = await _notesHttpClient.updateNote(
      params.id,
      params.toJson(),
    );
    return request.fold(
      (l) => Left(l),
      (r) => Right(
        BaseResponse.fromJson(r, (json) => NoteModel.fromJson(json)).data!,
      ),
    );
  }

  @override
  Future<Either<Failure, NoteModel>> getNote(int id) async {
    final request = await _notesHttpClient.getNote(id);
    return request.fold(
      (l) => Left(l),
      (r) => Right(
        BaseResponse.fromJson(r, (json) => NoteModel.fromJson(json)).data!,
      ),
    );
  }
}
