import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/core.dart';

@lazySingleton
class NotesHttpClient extends BaseHttpClient {
  NotesHttpClient(@Named(ClientModuleName.notes) super.dio);

  Future<Either<Failure, dynamic>> getNotes({
    Map<String, dynamic>? queryParameters,
  }) => get('', queryParams: queryParameters);

  Future<Either<Failure, dynamic>> postNote(Map<String, dynamic> body) =>
      post('', data: body);

  Future<Either<Failure, dynamic>> getNote(
    int id, {
    Map<String, dynamic>? queryParameters,
  }) => get('$id', queryParams: queryParameters);

  Future<Either<Failure, dynamic>> updateNote(
    int id,
    Map<String, dynamic> body,
  ) => put('$id', data: body);

  Future<Either<Failure, dynamic>> deleteNote(int id) => delete('$id');
}
