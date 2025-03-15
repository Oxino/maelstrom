import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';

///{@category Use Case}
///{@category User}
class GetCodeUseCase implements UseCase<RequestResult<bool>, String> {
  final UserRepository userRepository;

  const GetCodeUseCase({required this.userRepository});

  @override
  Future<RequestResult<bool>> call({required String params}) =>
      userRepository.getCode(username: params);
}
