import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/feature/user/domain/entity/base_user.dart';
import 'package:maelstorm/feature/user/domain/entity/login.dart';
import 'package:maelstorm/feature/user/domain/entity/update_password.dart';
import 'package:maelstorm/feature/user/domain/entity/validate_code.dart';

///{@category Repositories}
///{@category User}

abstract class UserRepository {
  ///Login user
  Future<RequestResult<BaseUser>> login({required Login login});

  ///Get code for update password
  Future<RequestResult<bool>> getCode({required String username});

  ///Validate if code for update password is valid
  Future<RequestResult<bool>> validateCode({required ValidateCode validateCode});

  ///Logout user
  Future<RequestResult<bool>> updatePassword({required UpdatePassword updatePassword});

  ///Update user
  Future<RequestResult<BaseUser>> updateUser({required BaseUser user});

  ///Logout user
  Future<RequestResult> logout();
}
