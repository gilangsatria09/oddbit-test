import 'package:dart_frog/dart_frog.dart';
import 'package:services/user_repository.dart';
import 'package:services/auth_service.dart';
import 'package:services/api_response.dart';

Future<Response> onRequest(RequestContext context) async {
  if (context.request.method != HttpMethod.post) {
    return Response(statusCode: 405);
  }

  final repo = context.read<UserRepository>();
  final auth = context.read<AuthService>();

  final body = await context.request.json() as Map<String, dynamic>;
  final username = body['username'] as String?;
  final password = body['password'] as String?;

  if (username == null ||
      username.isEmpty ||
      password == null ||
      password.length < 6) {
    return apiResponse(
      statusCode: 400,
      message: 'Username and password (min 6 chars) required',
    );
  }

  final existing = await repo.findByUsername(username);
  if (existing != null) {
    return apiResponse(
      statusCode: 409,
      message: 'Username already taken',
    );
  }

  final user = await repo.create(username, auth.hashPassword(password));
  return apiResponse(
    statusCode: 201,
    message: 'User registered successfully',
    data: {'id': user.id, 'username': user.username},
  );
}
