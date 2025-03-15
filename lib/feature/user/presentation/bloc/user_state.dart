///{@category Bloc}
///{@category User}

part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class InitialUserState extends UserState {
  @override
  List<Object> get props => [];
}

class LoadingUserState extends UserState {
  @override
  List<Object> get props => [];
}

class InitialSavedUserState extends UserState {
  final String username;
  final String password;

  const InitialSavedUserState({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class SendedCodeUserState extends UserState {
  @override
  List<Object> get props => [];
}

class LoggedUserState extends UserState {
  final BaseUser user;
  const LoggedUserState({required this.user});
  @override
  List<Object> get props => [user];
}

class LogoutedUserState extends UserState {
  @override
  List<Object> get props => [];
}

class PasswordChangedUserState extends UserState {
  @override
  List<Object> get props => [];
}

class PasswordUpdatedUserState extends UserState {
  @override
  List<Object> get props => [];
}

class UserUpdatedUserState extends UserState {
  @override
  List<Object> get props => [];
}

class CodeValidatedUserState extends UserState {
  @override
  List<Object> get props => [];
}
