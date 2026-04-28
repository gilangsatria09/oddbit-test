import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/core/storage/storage_keys.dart';
import 'package:notes_app/core/storage/storage_service.dart';

@LazySingleton(as: StorageService)
class StorageServiceImpl implements StorageService {
  final FlutterSecureStorage _flutterSecureStorage;

  StorageServiceImpl(this._flutterSecureStorage);

  @override
  Future<void> deleteSecureToken() {
    return _flutterSecureStorage.delete(key: StorageKeys.token.name);
  }

  @override
  Future<String?> readSecureToken() {
    return _flutterSecureStorage.read(key: StorageKeys.token.name);
  }

  @override
  Future<void> writeSecureToken(String token) {
    return _flutterSecureStorage.write(
      key: StorageKeys.token.name,
      value: token,
    );
  }
}
