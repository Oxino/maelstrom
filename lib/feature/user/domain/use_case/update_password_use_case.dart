import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/user/domain/entity/update_password.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';

///{@category Use Case}
///{@category User}
class UpdatePasswordUseCase implements UseCase<RequestResult<bool>, UpdatePassword> {
  final UserRepository userRepository;

  const UpdatePasswordUseCase({required this.userRepository});

  @override
  Future<RequestResult<bool>> call({required UpdatePassword params}) =>
      userRepository.updatePassword(updatePassword: params);
}
