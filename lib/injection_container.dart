import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:maelstorm/core/config/routes/router.dart';
import 'package:maelstorm/core/utils/dio/dio_client.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:maelstorm/feature/storage/data/repository_impl/storage_repository_impl.dart';
import 'package:maelstorm/feature/storage/domain/entity/storage_value.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';
import 'package:maelstorm/feature/alert/presentation/bloc/alert_bloc.dart';
import 'package:maelstorm/feature/storage/domain/use_case/del_all_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/del_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/del_temporary_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/get_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/load_asset_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/set_storage_use_case.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';
import 'package:maelstorm/feature/user/domain/use_case/get_code_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/login_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/logout_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/update_password_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/update_user_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/validate_code_use_case.dart';
import 'package:maelstorm/feature/user/presentation/bloc/user_bloc.dart';
import 'package:maelstorm/mocks/mock.dart';
import 'package:url_strategy/url_strategy.dart';

///{@category Config}

class InjectionContainer {
  final GetIt getIt;
  InjectionContainer({required this.getIt});

  final String baseLog = "InjectionContainer >";

  ///Initilize all app dependencies
  Future<void> initialize() async {
    log.i("$baseLog App initializing...");

    WidgetsFlutterBinding.ensureInitialized();
    setPathUrlStrategy();

    await initStorageDependencies();
    initGlobalDependencies();

    String? rylothUrl = await getIt<GetStorageUseCase>()(params: StorageValue.rylothUrl);
    if (rylothUrl == null) {
      log.e("$baseLog Initializer > initializeApp > rylothUrl not define");

      return;
    }

    await initUserDependencies();

    log.i("$baseLog App Initialize OK.");
  }

  Future<void> initStorageDependencies() async {
    log.i("$baseLog Initializing Storage Dependencies...");

    ///Repository
    getIt.registerSingleton<StorageRepository>(
        StorageRepositoryImpl(storage: const FlutterSecureStorage()));

    ///UseCase
    getIt.registerSingleton<LoadAssetUseCase>(LoadAssetUseCase(storageRepository: getIt()));
    getIt.registerSingleton<DelAllStorageUseCase>(DelAllStorageUseCase(storageRepository: getIt()));
    getIt.registerSingleton<DelStorageUseCase>(DelStorageUseCase(storageRepository: getIt()));
    getIt.registerSingleton<DelTemporaryStorageUseCase>(
        DelTemporaryStorageUseCase(storageRepository: getIt()));
    getIt.registerSingleton<GetStorageUseCase>(GetStorageUseCase(storageRepository: getIt()));
    getIt.registerSingleton<SetStorageUseCase>(SetStorageUseCase(storageRepository: getIt()));

    ///Load
    final String jsonString = await rootBundle.loadString('assets/config/config.json');
    await getIt<LoadAssetUseCase>()(params: jsonString);
  }

  Future<void> initGlobalDependencies() async {
    log.i("$baseLog Initializing Golbal Dependencises...");

    /// Dio
    getIt.registerSingleton<DioClient>(DioClient());
    getIt.registerSingleton<Dio>(getIt<DioClient>().instance);

    ///Router
    getIt.registerSingleton<RouterClient>(RouterClient());

    ///Notification bloc
    getIt.registerSingleton<AlertBloc>(AlertBloc(getStorageUseCase: getIt()));
  }

  Future<void> initUserDependencies() async {
    log.i("$baseLog Initializing User Dependencies...");

    ///Service

    ///Repository
    getIt.registerSingleton<UserRepository>(MockUserRepository());

    ///Use case
    getIt.registerSingleton<GetCodeUseCase>(GetCodeUseCase(userRepository: getIt()));
    getIt.registerSingleton<LoginUseCase>(LoginUseCase(userRepository: getIt()));
    getIt.registerSingleton<LogoutUseCase>(LogoutUseCase(userRepository: getIt()));
    getIt.registerSingleton<UpdatePasswordUseCase>(UpdatePasswordUseCase(userRepository: getIt()));
    getIt.registerSingleton<UpdateUserUseCase>(UpdateUserUseCase(userRepository: getIt()));
    getIt.registerSingleton<ValidateCodeUseCase>(ValidateCodeUseCase(userRepository: getIt()));

    ///Bloc
    getIt.registerSingleton<UserBloc>(UserBloc(
      getCodeUseCase: getIt(),
      loginUseCase: getIt(),
      logoutUseCase: getIt(),
      updatePasswordUseCase: getIt(),
      updateUserUseCase: getIt(),
      validateCodeUseCase: getIt(),
      notificationBloc: getIt(),
      getCurrentUserUseCase: getIt(),
      getStorageUseCase: getIt(),
    )..add(const InitializeUserEvent()));
  }
}
