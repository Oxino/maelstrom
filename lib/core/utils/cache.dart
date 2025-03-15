import 'package:collection/collection.dart';
import 'package:maelstorm/core/utils/log.dart';

class CacheItem<T> {
  final String id;
  late DateTime lastTime;
  T value;

  CacheItem({required this.id, required this.value}) {
    lastTime = DateTime.now();
  }

  bool get isExpired => DateTime.now().difference(lastTime) <= Cache.cacheDuration;

  void update(T newValue) {
    lastTime = DateTime.now();
    value = newValue;
  }

  void expire(String id) => lastTime = DateTime(0);

  @override
  String toString() => "CacheItem(id: $id, lastTime: $lastTime, vaue: $value)";
}

class Cache<T> {
  Cache() {
    cacheItemList = <CacheItem<T>>[];
  }

  static const cacheDuration = Duration(minutes: 240);
  late final List<CacheItem<T>> cacheItemList;

  void addCacheItem(String id, T value) {
    CacheItem<T> newItem = CacheItem<T>(id: id, value: value);
    log.d("Cache > createCache > add $newItem");
    cacheItemList.add(newItem);
    return;
  }

  T? getCachedValue(String id) {
    CacheItem<T>? item = find(id);
    if (item == null || item.isExpired) return null;

    return item.value;
  }

  CacheItem<T>? find(String id) =>
      cacheItemList.firstWhereOrNull((CacheItem<T> item) => item.id == id);

  void updateCache(String id, T value) {
    CacheItem<T>? cacheItem = find(id);

    if (cacheItem == null) {
      addCacheItem(id, value);
      return;
    }

    cacheItem.update(value);
    log.d("Cache > updateCache > update $cacheItem");
  }

  void removeCacheItem(String id) =>
      cacheItemList.removeWhere((CacheItem<T> item) => item.id == id);

  void removeAllCache() => cacheItemList.clear();
}
