import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/user/domain/entity/base_user.dart';
import 'package:maelstorm/feature/user/domain/entity/login.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';

///{@category Use Case}
///{@category User}
class LoginUseCase implements UseCase<RequestResult<BaseUser>, Login> {
  final UserRepository userRepository;

  const LoginUseCase({required this.userRepository});

  @override
  Future<RequestResult<BaseUser>> call({required Login params}) =>
      userRepository.login(login: params);
}
