import 'package:equatable/equatable.dart';

///{@category Params}
///{@category User}
class ValidateCode extends Equatable {
  final String username;
  final String code;

  const ValidateCode({required this.username, required this.code});

  @override
  List<Object?> get props => [
        username,
        code,
      ];
}
