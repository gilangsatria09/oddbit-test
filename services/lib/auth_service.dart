import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'env/env.dart';

class AuthService {
  String hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  bool verifyPassword(String plain, String hashed) =>
      hashPassword(plain) == hashed;

  String generateToken(int userId, String username) {
    final jwt = JWT(
      {'userId': userId, 'username': username},
      issuer: 'notes_app',
    );
    return jwt.sign(
      SecretKey(Env.jwtSecret),
      expiresIn: const Duration(hours: 24),
    );
  }

  /// Returns payload if valid, null if invalid/expired.
  Map<String, dynamic>? verifyToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(Env.jwtSecret));
      return jwt.payload as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
