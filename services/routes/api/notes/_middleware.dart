import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_auth/dart_frog_auth.dart';
import 'package:services/database.dart';
import 'package:services/user_repository.dart';

Handler middleware(Handler handler) {
  return handler.use(
    bearerAuthentication<User>(
      authenticator: (context, token) {
        final repo = context.read<UserRepository>();
        return repo.fetchFromToken(context, token);
      },
    ),
  );
}
