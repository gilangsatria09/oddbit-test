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

Future<Response> onRequest(RequestContext context) async {
  final user = context.read<User>();
  final userId = user.id;
  final repo = context.read<NoteRepository>();

  switch (context.request.method) {
    case HttpMethod.get:
      final notes = await repo.getAllByUser(userId);
      return apiResponse(
        statusCode: 200,
        message: 'Notes fetched successfully',
        data: notes.map(_noteToJson).toList(),
      );

    case HttpMethod.post:
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

      final note = await repo.create(userId, title, content);
      return apiResponse(
        statusCode: 201,
        message: 'Note created successfully',
        data: _noteToJson(note),
      );

    default:
      return Response(statusCode: 405);
  }
}
