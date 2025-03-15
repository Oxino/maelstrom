import 'package:equatable/equatable.dart';

///{@category Params}
///{@category User}

class Login extends Equatable {
  final String email;
  final String password;
  final bool isRemember;

  const Login({required this.email, required this.password, required this.isRemember});

  @override
  List<Object?> get props => [email, password, isRemember];
}
