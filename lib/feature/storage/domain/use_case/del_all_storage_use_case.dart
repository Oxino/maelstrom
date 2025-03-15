import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';

///{@category Use Case}
///{@category User}
class DelAllStorageUseCase implements UseCase<void, void> {
  final StorageRepository storageRepository;

  const DelAllStorageUseCase({required this.storageRepository});

  @override
  Future<void> call({required void params}) => storageRepository.delAllStorage();
}
