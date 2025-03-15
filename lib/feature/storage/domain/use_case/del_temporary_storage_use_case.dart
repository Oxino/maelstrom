import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';

///{@category Use Case}
///{@category User}
class DelTemporaryStorageUseCase implements UseCase<void, void> {
  final StorageRepository storageRepository;

  const DelTemporaryStorageUseCase({required this.storageRepository});

  @override
  Future<void> call({required void params}) => storageRepository.delTemporaryStorage();
}
