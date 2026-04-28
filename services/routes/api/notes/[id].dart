import 'package:dart_frog/dart_frog.dart';
import 'package:services/database.dart';
import 'package:services/note_repository.dart';
import 'package:services/api_response.dart';

Map<String, dynamic> _noteToJson(dynamic note) => {
      'id': note.id,
      'title': note.title,
      'content': note.content,
      'createdAt': note.createdAt.toIso8601String(),
      'updatedAt': note.updatedAt.toIso8601String(),
    };

Future<Response> onRequest(RequestContext context, String id) async {
  final noteId = int.tryParse(id);
  if (noteId == null) {
    return apiResponse(statusCode: 400, message: 'Invalid note ID');
  }

  final user = context.read<User>();
  final userId = user.id;
  final repo = context.read<NoteRepository>();

  switch (context.request.method) {
    case HttpMethod.get:
      final note = await repo.getByIdAndUser(noteId, userId);
      if (note == null) {
        return apiResponse(statusCode: 404, message: 'Note not found');
      }
      return apiResponse(
        statusCode: 200,
        message: 'Note fetched successfully',
        data: _noteToJson(note),
      );

    case HttpMethod.put:
      final Map<String, dynamic> body;
      try {
        body = await context.request.json() as Map<String, dynamic>;
      } catch (_) {
        return apiResponse(statusCode: 400, message: 'Invalid JSON body');
      }

      final title = (body['title'] as String?)?.trim();
      final content = (body['content'] as String?)?.trim();

      if (title == null || title.isEmpty) {
        return apiResponse(statusCode: 400, message: 'Title is required');
      }
      if (content == null || content.isEmpty) {
        return apiResponse(statusCode: 400, message: 'Content is required');
      }

      final updated =
          await repo.update(noteId, userId, title: title, content: content);
      if (!updated) {
        return apiResponse(statusCode: 404, message: 'Note not found');
      }

      final note = await repo.getByIdAndUser(noteId, userId);
      return apiResponse(
        statusCode: 200,
        message: 'Note updated successfully',
        data: _noteToJson(note!),
      );

    case HttpMethod.delete:
      final deleted = await repo.delete(noteId, userId);
      if (!deleted) {
        return apiResponse(statusCode: 404, message: 'Note not found');
      }
      return apiResponse(statusCode: 200, message: 'Note deleted successfully');

    default:
      return Response(statusCode: 405);
  }
}
