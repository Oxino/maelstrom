import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maelstorm/core/utils/dio/dio_client.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:maelstorm/feature/alert/presentation/bloc/alert_bloc.dart';
import 'package:maelstorm/feature/storage/data/repository_impl/storage_repository_impl.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';
import 'package:maelstorm/feature/storage/domain/use_case/del_all_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/del_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/del_temporary_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/get_storage_use_case.dart';
import 'package:maelstorm/feature/storage/domain/use_case/load_asset_use_case.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';
import 'package:maelstorm/feature/user/domain/use_case/get_code_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/login_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/logout_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/update_password_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/update_user_use_case.dart';
import 'package:maelstorm/feature/user/domain/use_case/validate_code_use_case.dart';
import 'package:maelstorm/feature/user/presentation/bloc/user_bloc.dart';
import 'package:maelstorm/injection_container.dart';
import 'package:maelstorm/mocks/mock.dart';
import 'mocks/mock.dart';

class TestInitializer extends InjectionContainer {
  TestInitializer({required super.getIt});

  @override
  Future<void> initialize() async {
    log.i("Test initializing...");
    TestWidgetsFlutterBinding.ensureInitialized();

    await initStorageDependencies();
    initGlobalDependencies();
    await initUserDependencies();

    log.i("Test initialize OK.");
  }

  @override
  Future<void> initStorageDependencies() async {
    log.i("Initializing Storage Dependencies...");

    /// Storage
    getIt.registerSingleton<StorageRepository>(MockStorageRepository());
    FlutterSecureStorage.setMockInitialValues({});
    getIt.registerSingleton<StorageRepositoryImpl>(
        StorageRepositoryImpl(storage: const FlutterSecureStorage()));

    ///UseCase
    getIt.registerSingleton<LoadAssetUseCase>(LoadAssetUseCase(storageRepository: getIt()));
    getIt.registerSingleton<DelAllStorageUseCase>(DelAllStorageUseCase(storageRepository: getIt()));
    getIt.registerSingleton<DelStorageUseCase>(DelStorageUseCase(storageRepository: getIt()));
    getIt.registerSingleton<DelTemporaryStorageUseCase>(
        DelTemporaryStorageUseCase(storageRepository: getIt()));
    getIt.registerSingleton<GetStorageUseCase>(GetStorageUseCase(storageRepository: getIt()));
  }

  @override
  Future<void> initGlobalDependencies() async {
    log.i("Initializing Golbal Dependencises...");

    ///Notification bloc
    getIt.registerSingleton<AlertBloc>(MockAlertBloc());

    /// Dio
    getIt.registerSingleton<DioClient>(MockDioClient());
  }

  @override
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

    ///User
    getIt.registerSingleton<UserBloc>(UserBloc(
        getCodeUseCase: getIt(),
        loginUseCase: getIt(),
        logoutUseCase: getIt(),
        updatePasswordUseCase: getIt(),
        updateUserUseCase: getIt(),
        validateCodeUseCase: getIt(),
        notificationBloc: getIt(),
        getCurrentUserUseCase: getIt(),
        getStorageUseCase: getIt()));
  }
}
