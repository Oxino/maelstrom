import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/core/utils/use_case.dart';
import 'package:maelstorm/feature/user/domain/entity/validate_code.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';

///{@category Use Case}
///{@category User}
class ValidateCodeUseCase implements UseCase<RequestResult<bool>, ValidateCode> {
  final UserRepository userRepository;

  const ValidateCodeUseCase({required this.userRepository});

  @override
  Future<RequestResult<bool>> call({required ValidateCode params}) =>
      userRepository.validateCode(validateCode: params);
}
