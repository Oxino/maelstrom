import 'package:flutter_test/flutter_test.dart';
import 'package:maelstorm/feature/storage/data/repository_impl/storage_repository_impl.dart';
import 'package:maelstorm/feature/storage/domain/entity/set_storage.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';
import 'package:maelstorm/global.dart';
import 'package:mocktail/mocktail.dart';

import '../../test_injection.dart';

void main() async {
  await TestInitializer(getIt: getIt).initialize();

  TestWidgetsFlutterBinding.ensureInitialized();
  final StorageRepositoryImpl secureStorageImpl = getIt<StorageRepositoryImpl>();

  const String rylothUrlExemple = "https://ryloth.edi.fr";
  String jsonString = "{\"${StorageValue.rylothUrl.name}\":\"$rylothUrlExemple\"}";
  const String refreshTokenExemple = "LJHGLUEUKEH:EO";
  const String usernameExemple = "user_id";

  setUp(() {
    registerFallbackValue(String);
  });

  test('SecureStorageParam > find > Success', () {
    StorageValue? configParam = StorageValue.find("rylothUrl");
    expect(configParam, StorageValue.rylothUrl);
  });

  test('SecureStorageParam > find > Fail', () {
    StorageValue? configParam = StorageValue.find("dontExiste");
    expect(configParam, null);
  });

  test('SecureStorage > init > Success', () {
    expect(secureStorageImpl.allValues.isEmpty, true);
  });

  test('SecureStorage > loadAsset(empty) > Success empty', () async {
    await secureStorageImpl.loadAsset(jsonString: '');

    expect(secureStorageImpl.allValues.isEmpty, true);
  });

  test('SecureStorage > loadAsset(not empty) > Success empty', () async {
    await secureStorageImpl.loadAsset(jsonString: jsonString);

    expect(secureStorageImpl.allValues[StorageValue.rylothUrl], rylothUrlExemple);
  });

  test('SecureStorage > setConf > Success', () {
    secureStorageImpl.setStorage(
        setStorage: const SetStorage(key: StorageValue.refreshToken, value: refreshTokenExemple));

    expect(secureStorageImpl.allValues[StorageValue.refreshToken], refreshTokenExemple);
  });
  test('SecureStorage > setConf > Fail', () {
    secureStorageImpl.setStorage(
        setStorage: const SetStorage(key: StorageValue.accessToken, value: ''));

    expect(secureStorageImpl.allValues.containsKey(StorageValue.accessToken), false);
  });

  test('SecureStorage > getConf > Success', () async {
    expect(await secureStorageImpl.getStorage(key: StorageValue.refreshToken), refreshTokenExemple);
  });
  test('SecureStorage > getConf > Fail', () async {
    expect(await secureStorageImpl.getStorage(key: StorageValue.username), null);
  });

  test('SecureStorage > delConf > Success', () async {
    secureStorageImpl.delStorage(key: StorageValue.refreshToken);
    expect(await secureStorageImpl.getStorage(key: StorageValue.rylothUrl), rylothUrlExemple);
    expect(await secureStorageImpl.getStorage(key: StorageValue.refreshToken), null);
  });

  test('SecureStorage > delTemporaryConf > Success', () async {
    secureStorageImpl.setStorage(
        setStorage: const SetStorage(key: StorageValue.refreshToken, value: refreshTokenExemple));
    secureStorageImpl.setStorage(
        setStorage: const SetStorage(key: StorageValue.username, value: usernameExemple));

    await secureStorageImpl.delTemporaryStorage();

    expect(await secureStorageImpl.getStorage(key: StorageValue.rylothUrl), rylothUrlExemple);
    expect(await secureStorageImpl.getStorage(key: StorageValue.username), usernameExemple);
    expect(await secureStorageImpl.getStorage(key: StorageValue.refreshToken), null);
  });

  test('SecureStorage > delAllConf > Success', () async {
    secureStorageImpl.setStorage(
        setStorage: const SetStorage(key: StorageValue.refreshToken, value: refreshTokenExemple));
    secureStorageImpl.setStorage(
        setStorage: const SetStorage(key: StorageValue.username, value: usernameExemple));

    secureStorageImpl.delAllStorage();

    expect(await secureStorageImpl.getStorage(key: StorageValue.rylothUrl), null);
    expect(await secureStorageImpl.getStorage(key: StorageValue.refreshToken), null);
    expect(await secureStorageImpl.getStorage(key: StorageValue.username), null);
  });
}
