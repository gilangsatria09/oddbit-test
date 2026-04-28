import 'package:dart_frog/dart_frog.dart';
import 'package:services/database.dart';
import 'package:services/auth_service.dart';
import 'package:services/user_repository.dart';
import 'package:services/note_repository.dart';
import 'package:services/api_response.dart';

final _db = AppDatabase();
final _authService = AuthService();
final _userRepo = UserRepository(_db, _authService);

Handler middleware(Handler handler) {
  final withProviders = handler
      .use(provider<AppDatabase>((_) => _db))
      .use(provider<AuthService>((_) => _authService))
      .use(provider<UserRepository>((_) => _userRepo))
      .use(provider<NoteRepository>((_) => NoteRepository(_db)));

  return (context) async {
    try {
      return await withProviders(context);
    } catch (_) {
      return apiResponse(statusCode: 500, message: 'Internal server error');
    }
  };
}
