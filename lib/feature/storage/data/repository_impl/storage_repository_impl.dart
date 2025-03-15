import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:maelstorm/feature/storage/domain/entity/set_storage.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';
import 'package:synchronized/synchronized.dart';

class StorageRepositoryImpl extends StorageRepository {
  final FlutterSecureStorage _storage;
  final Map<StorageValue, dynamic> allValues = {};
  final lock = Lock();

  StorageRepositoryImpl({
    required FlutterSecureStorage storage,
  }) : _storage = storage;

  @override
  Future<void> loadAsset({required String jsonString}) async {
    if (jsonString != '') {
      log.d("SecureStorageImpl > loadAsset > load asset in json");

      dynamic contents = json.decode(jsonString);

      await lock.synchronized(() async {
        for (var key in contents.keys) {
          StorageValue? appConfigParam = StorageValue.find(key);
          if (appConfigParam != null) {
            allValues[appConfigParam] =
                await _storage.read(key: appConfigParam.name) ?? contents[key];
          }
        }
      });
    }

    log.d("SecureStorageImpl > loadAsset");
    for (StorageValue configParam in StorageValue.values) {
      String? value = await _storage.read(key: configParam.name);
      if (value != null) {
        allValues[configParam] = value;
      }
    }
  }

  @override
  Future<void> setStorage({required SetStorage setStorage}) async {
    if (setStorage.value == '') return;

    allValues[setStorage.key] = setStorage.value;
    lock.synchronized(() async {
      await _storage.write(key: setStorage.key.name, value: setStorage.value);
    });

    log.d("SecureStorageImpl > setConf > ${setStorage.key}: ${setStorage.value}");
  }

  @override
  Future<String?> getStorage({required StorageValue key}) async {
    if (!allValues.containsKey(key)) {
      log.d("Configuration > getConf ? $key key not found");
      return null;
    }

    log.d("SecureStorageImpl > getConf > $key: ${allValues[key]!}");
    return allValues[key]!;
  }

  @override
  Future<void> delStorage({required StorageValue key}) async {
    lock.synchronized(() async {
      await _storage.delete(key: key.name);
    });
    allValues.remove(key);
  }

  @override
  Future<void> delAllStorage() async {
    lock.synchronized(() async {
      await _storage.deleteAll();
    });

    allValues.clear();
    log.d("SecureStorageImpl > delAllConf");
  }

  @override
  Future<void> delTemporaryStorage() async {
    List<StorageValue> temporatyStorageValue =
        StorageValue.values.where((StorageValue value) => value.isTemporary).toList();
    lock.synchronized(() async {
      for (StorageValue configParam in temporatyStorageValue) {
        await _storage.delete(key: configParam.name);
      }
    });

    for (StorageValue configParam in temporatyStorageValue) {
      allValues.remove(configParam);
    }
    log.d("SecureStorageImpl > delTemporaryConf");
  }
}
