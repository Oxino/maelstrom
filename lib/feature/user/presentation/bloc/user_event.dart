///{@category Bloc}
///{@category User}

part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class InitializeUserEvent extends UserEvent {
  const InitializeUserEvent();
  @override
  List<Object> get props => [];
}

class GetCodeUserEvent extends UserEvent {
  final String username;

  const GetCodeUserEvent({required this.username});
  @override
  List<Object> get props => [username];
}

class LoginUserEvent extends UserEvent {
  final Login login; // Change

  const LoginUserEvent({required this.login});

  @override
  List<Object> get props => [login];
}

class LogoutUserEvent extends UserEvent {
  const LogoutUserEvent();

  @override
  List<Object> get props => [];
}

class UpdatePasswordUserEvent extends UserEvent {
  final UpdatePassword updatePassword;

  const UpdatePasswordUserEvent({required this.updatePassword});

  @override
  List<Object> get props => [updatePassword];
}

class UpdateUserUserEvent extends UserEvent {
  final BaseUser user;

  const UpdateUserUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class ValidateCodeUserEvent extends UserEvent {
  final ValidateCode validateCode;

  const ValidateCodeUserEvent({required this.validateCode});

  @override
  List<Object> get props => [validateCode];
}
