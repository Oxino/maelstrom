import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';

///{@category Use Case}
///{@category User}
class GetStorageUseCase implements UseCase<String?, StorageValue> {
  final StorageRepository storageRepository;

  const GetStorageUseCase({required this.storageRepository});

  @override
  Future<String?> call({required StorageValue params}) => storageRepository.getStorage(key: params);
}
