part of "alert_bloc.dart";

abstract class AlertState extends Equatable {
  const AlertState();
}

///Notification initial state
class InitialAlertState extends AlertState {
  const InitialAlertState();

  @override
  List<Object?> get props => [];
}

///Notification loading state
class LoadingAlertState extends AlertState {
  const LoadingAlertState();

  @override
  List<Object?> get props => [];
}

///Notification loading state
class ErrorAlertState extends AlertState {
  final String message;
  const ErrorAlertState({required this.message});

  @override
  List<Object?> get props => [message];
}

class WarningAlertState extends AlertState {
  final String message;
  const WarningAlertState({required this.message});

  @override
  List<Object?> get props => [message];
}

class InfoAlertState extends AlertState {
  final String message;
  const InfoAlertState({required this.message});

  @override
  List<Object?> get props => [message];
}
