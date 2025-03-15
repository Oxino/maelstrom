import 'package:collection/collection.dart';
import 'package:maelstorm/core/utils/log.dart';

///Describe all values [StorageRepository] can accepts
enum StorageValue {
  rylothUrl(isTemporary: false),
  username(isTemporary: false),
  password(isTemporary: false),
  accessToken,
  refreshToken;

  final bool isTemporary;

  const StorageValue({this.isTemporary = true});

  ///Find [StorageValue] by name.
  ///
  ///if existe return [StorageValue] else return `null`
  static StorageValue? find(String key) {
    StorageValue? test = StorageValue.values
        .firstWhereOrNull((StorageValue appConfigParam) => appConfigParam.name == key);

    if (test == null) {
      log.e('AppConfigParam > find > $key not found');
      return null;
    }

    return test;
  }
}
