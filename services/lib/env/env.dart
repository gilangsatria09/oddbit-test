import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'JWT_SECRET', obfuscate: true)
  static final String jwtSecret = _Env.jwtSecret;

  @EnviedField(varName: 'DB_PATH')
  static final String dbPath = _Env.dbPath;

  @EnviedField(varName: 'PORT', defaultValue: '8080')
  static final String port = _Env.port;
}
