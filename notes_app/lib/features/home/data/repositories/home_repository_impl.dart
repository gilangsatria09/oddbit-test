import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/errors/failure.dart';
import 'package:notes_app/features/home/data/datasources/remote/home_remote_data_source.dart';
import 'package:notes_app/features/home/domain/entities/note_entity.dart';
import 'package:notes_app/features/home/domain/params/params.dart';
import 'package:notes_app/features/home/domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, NoteEntity>> createNote(PostNoteParams params) {
    return _remoteDataSource
        .createNote(params)
        .then(
          (value) => value.fold((l) => Left(l), (r) => Right(r.toEntity())),
        );
  }

  @override
  Future<Either<Failure, String>> deleteNote(int id) {
    return _remoteDataSource
        .deleteNote(id)
        .then((value) => value.fold((l) => Left(l), (r) => Right(r)));
  }

  @override
  Future<Either<Failure, NoteEntity>> getNote(int id) {
    return _remoteDataSource
        .getNote(id)
        .then(
          (value) => value.fold((l) => Left(l), (r) => Right(r.toEntity())),
        );
  }

  @override
  Future<Either<Failure, List<NoteEntity>>> getNotes() {
    return _remoteDataSource.getNotes().then(
      (value) => value.fold(
        (l) => Left(l),
        (r) => Right(r.map((e) => e.toEntity()).toList()),
      ),
    );
  }

  @override
  Future<Either<Failure, NoteEntity>> updateNote(UpdateNoteParams params) {
    return _remoteDataSource
        .updateNote(params)
        .then(
          (value) => value.fold((l) => Left(l), (r) => Right(r.toEntity())),
        );
  }
}
