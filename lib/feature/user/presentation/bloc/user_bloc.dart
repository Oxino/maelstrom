import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:maelstorm/core/utils/request_result.dart';
import 'package:maelstorm/core/utils/status_code.dart';
import 'package:maelstorm/feature/alert/presentation/bloc/alert_bloc.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';
import 'package:maelstorm/feature/storage/domain/use_case/get_storage_use_case.dart';
import 'package:maelstorm/feature/user/domain/entity/base_user.dart';
import 'package:maelstorm/feature/user/domain/entity/login.dart';
import 'package:maelstorm/feature/user/domain/entity/update_password.dart';
import 'package:maelstorm/feature/user/domain/entity/validate_code.dart';
import 'package:maelstorm/feature/user/domain/use_case/get_code_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/login_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/logout_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/update_password_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/update_user_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/validate_code_use_case.dart';

///{@category Bloc}
///{@category User}

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetCodeUseCase getCodeUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final UpdateUserUseCase updateUserUseCase;
  final ValidateCodeUseCase validateCodeUseCase;
  final AlertBloc notificationBloc;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final GetStorageUseCase getStorageUseCase;
  UserBloc(
      {required this.getCodeUseCase,
      required this.loginUseCase,
      required this.logoutUseCase,
      required this.updatePasswordUseCase,
      required this.updateUserUseCase,
      required this.validateCodeUseCase,
      required this.notificationBloc,
      required this.getStorageUseCase,
      required this.getCurrentUserUseCase})
      : super(InitialUserState()) {
    on<InitializeUserEvent>(_initilize);
    on<GetCodeUserEvent>(_getCode);
    on<LoginUserEvent>(_login);
    on<LogoutUserEvent>(_logout);
    on<UpdatePasswordUserEvent>(_updatePassword);
    on<UpdateUserUserEvent>(_updateUser);
    on<ValidateCodeUserEvent>(_validateCode);
  }

  void _initilize(InitializeUserEvent event, Emitter<UserState> emit) async {
    log.d("UserBloc > initilize");
    BaseUser? currentUser = null;

    if (currentUser != null) {
      emit(LoggedUserState(user: currentUser));
      return;
    }

    String? savedUsername = await getStorageUseCase(params: StorageValue.username);
    if (savedUsername != null) {
      String? savedPassword = await getStorageUseCase(params: StorageValue.password);

      emit(InitialSavedUserState(username: savedUsername, password: savedPassword!));
      return;
    }

    emit(InitialUserState());
  }

  void _getCode(GetCodeUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());
    RequestResult<bool> getCodeResponse = await getCodeUseCase(params: event.username);

    if (getCodeResponse is RequestSuccess) {
      emit(SendedCodeUserState());
    }
  }

  void _login(LoginUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());

    if (event.login.email.isEmpty || event.login.password.isEmpty) {
      notificationBloc.add(const ErrorAlertEvent(statusCode: StatusCode.fillAllField));
      return;
    }

    RequestResult<BaseUser> loginResponse = await loginUseCase(params: event.login);

    if (loginResponse is RequestSuccess) {
      emit(LoggedUserState(user: (loginResponse as RequestSuccess).data!));
    }
  }

  void _logout(LogoutUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());

    RequestResult<void> logoutResponse = await logoutUseCase(params: null);

    if (logoutResponse is RequestSuccess) {
      emit(LogoutedUserState());
    }
  }

  void _updatePassword(UpdatePasswordUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());

    RequestResult<bool> updatePasswordResponse =
        await updatePasswordUseCase(params: event.updatePassword);

    if (updatePasswordResponse is RequestSuccess) {
      emit(PasswordUpdatedUserState());
    }
  }

  void _updateUser(UpdateUserUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());

    RequestResult<BaseUser> updateUserResponse = await updateUserUseCase(params: event.user);

    if (updateUserResponse is RequestSuccess) {
      emit(UserUpdatedUserState());
    }
  }

  void _validateCode(ValidateCodeUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());

    RequestResult<bool> updateUserResponse = await validateCodeUseCase(params: event.validateCode);

    if (updateUserResponse is RequestSuccess) {
      emit(CodeValidatedUserState());
    }
  }
}

class GetCurrentUserUseCase {}
