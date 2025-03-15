import 'package:maelstorm/core/utils/dio/dio_client.dart';
import 'package:maelstorm/feature/network/network/bloc/notification_bloc.dart';
import 'package:maelstorm/feature/storage/domain/repositories/storage_repository.dart';
import 'package:maelstorm/feature/user/domain/repository/user_repository.dart';
import 'package:mocktail/mocktail.dart';

///Global
class MockDioClient extends Mock implements DioClient {}

///Services

///Repository
class MockStorageRepository extends Mock implements StorageRepository {}

class MockUserRepository extends Mock implements UserRepository {}

///Bloc
class MockNotificationBloc extends Mock implements NotificationBloc {}
