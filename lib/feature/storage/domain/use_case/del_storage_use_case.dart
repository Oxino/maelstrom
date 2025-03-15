import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';

///{@category Use Case}
///{@category User}
class DelStorageUseCase implements UseCase<void, StorageValue> {
  final StorageRepository storageRepository;

  const DelStorageUseCase({required this.storageRepository});

  @override
  Future<void> call({required StorageValue params}) => storageRepository.delStorage(key: params);
}
