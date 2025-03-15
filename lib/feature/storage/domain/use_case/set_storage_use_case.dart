import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/storage/domain/entity/set_storage.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';

///{@category Use Case}
///{@category User}
class SetStorageUseCase implements UseCase<void, SetStorage> {
  final StorageRepository storageRepository;

  const SetStorageUseCase({required this.storageRepository});

  @override
  Future<void> call({required SetStorage params}) =>
      storageRepository.setStorage(setStorage: params);
}
