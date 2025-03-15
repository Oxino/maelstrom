import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';

///{@category Use Case}
///{@category User}
class LogoutUseCase implements UseCase<RequestResult<void>, Null> {
  final UserRepository userRepository;

  const LogoutUseCase({required this.userRepository});

  @override
  Future<RequestResult<void>> call({required void params}) => userRepository.logout();
}
