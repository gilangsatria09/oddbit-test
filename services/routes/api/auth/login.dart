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

  if (username == null || password == null) {
    return apiResponse(
      statusCode: 400,
      message: 'Missing credentials',
    );
  }

  final user = await repo.findByUsername(username);
  if (user == null || !auth.verifyPassword(password, user.hashedPassword)) {
    return apiResponse(
      statusCode: 401,
      message: 'Invalid credentials',
    );
  }

  final token = auth.generateToken(user.id, user.username);
  return apiResponse(
    statusCode: 200,
    message: 'Login successful',
    data: {'token': token},
  );
}
