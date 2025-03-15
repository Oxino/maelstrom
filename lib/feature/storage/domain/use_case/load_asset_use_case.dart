import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';

///{@category Use Case}
///{@category User}
class LoadAssetUseCase implements UseCase<void, String> {
  final StorageRepository storageRepository;

  const LoadAssetUseCase({required this.storageRepository});

  @override
  Future<void> call({required String params}) => storageRepository.loadAsset(jsonString: params);
}
