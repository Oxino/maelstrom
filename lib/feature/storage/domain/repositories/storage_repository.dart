import 'package:maelstorm/feature/storage/domain/entity/set_storage.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';

abstract class StorageRepository {
  Future<void> loadAsset({required String jsonString});
  Future<void> setStorage({required SetStorage setStorage});
  // Future<User?> getCurrentUser();
  Future<String?> getStorage({required StorageValue key});
  Future<void> delStorage({required StorageValue key});
  Future<void> delAllStorage();
  Future<void> delTemporaryStorage();
}
