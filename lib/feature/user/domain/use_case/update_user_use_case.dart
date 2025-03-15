import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/user/domain/entity/base_user.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';

///{@category Use Case}
///{@category User}
class UpdateUserUseCase implements UseCase<RequestResult<BaseUser>, BaseUser> {
  final UserRepository userRepository;

  const UpdateUserUseCase({required this.userRepository});

  @override
  Future<RequestResult<BaseUser>> call({required BaseUser params}) =>
      userRepository.updateUser(user: params);
}
