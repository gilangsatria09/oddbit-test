abstract class StorageService {
  Future<void> writeSecureToken(String token);
  Future<String?> readSecureToken();
  Future<void> deleteSecureToken();
}
