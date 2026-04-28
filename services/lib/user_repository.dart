import 'package:dart_frog/dart_frog.dart';
import 'auth_service.dart';
import 'database.dart';

class UserRepository {
  final AppDatabase db;
  final AuthService authService;

  UserRepository(this.db, this.authService);

  Future<User?> findByUsername(String username) => (db.select(
        db.users,
      )..where((u) => u.username.equals(username)))
          .getSingleOrNull();

  Future<User?> findById(int id) =>
      (db.select(db.users)..where((u) => u.id.equals(id))).getSingleOrNull();

  Future<User> create(String username, String hashedPassword) async {
    await db.into(db.users).insert(
          UsersCompanion.insert(
            username: username,
            hashedPassword: hashedPassword,
          ),
        );
    return findByUsername(username).then((u) => u!);
  }

  Future<User?> fetchFromToken(RequestContext context, String token) async {
    final payload = authService.verifyToken(token);
    if (payload == null) return null;
    final userId = payload['userId'] as int?;
    if (userId == null) return null;
    return findById(userId);
  }
}
