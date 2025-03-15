import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maelstorm/core/utils/log.dart';
import 'package:maelstorm/core/utils/status_code.dart';
import 'package:maelstorm/feature/storage/domain/use_case/get_storage_use_case.dart';

part "alert_event.dart";
part "alert_state.dart";

///Bloc dedicate to notify user
///
///Needed in all blocs
class AlertBloc extends Bloc<AlertEvent, AlertState> {
  final GetStorageUseCase getStorageUseCase;
  AlertBloc({required this.getStorageUseCase}) : super(const InitialAlertState()) {
    on<ErrorAlertEvent>(_sendError);
    on<WarningAlertEvent>(_sendWarning);
    on<InfoAlertEvent>(_sendInfo);
    on<ClearAlertEvent>(_clear);
  }

  final Duration infoRemoveDuration = const Duration(seconds: 10);
  final Duration warningRemoveDuration = const Duration(seconds: 25);

  void _sendError(ErrorAlertEvent event, Emitter<AlertState> emit) async {
    emit(const LoadingAlertState());

    log.e('NotificationBloc > sendError > ${event.statusCode}');

    emit(ErrorAlertState(message: event.statusCode.message));
  }

  void _sendWarning(WarningAlertEvent event, Emitter<AlertState> emit) async {
    log.w('NotificationBloc > sendWarning > ${event.message}');

    emit(WarningAlertState(message: event.message));

    await Future.delayed(warningRemoveDuration);
    emit(const InitialAlertState());
  }

  void _sendInfo(InfoAlertEvent event, Emitter<AlertState> emit) async {
    log.i('NotificationBloc > sendInfo > ${event.message}');
    emit(InfoAlertState(message: event.message));

    await Future.delayed(infoRemoveDuration);
    emit(const InitialAlertState());
  }

  void _clear(ClearAlertEvent event, Emitter<AlertState> emit) {
    emit(const InitialAlertState());
  }
}
