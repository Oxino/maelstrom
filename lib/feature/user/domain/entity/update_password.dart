import 'package:equatable/equatable.dart';

///{@category Params}
///{@category User}
class UpdatePassword extends Equatable {
  final String username;
  final String password;
  final String confirmPassword;

  const UpdatePassword(
      {required this.username, required this.password, required this.confirmPassword});

  @override
  List<Object?> get props => [username, password, confirmPassword];
}
