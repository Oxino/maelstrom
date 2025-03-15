part of "alert_bloc.dart";

abstract class AlertEvent extends Equatable {
  const AlertEvent();
}

class ErrorAlertEvent extends AlertEvent {
  final StatusCode statusCode;

  const ErrorAlertEvent({required this.statusCode});

  @override
  List<Object?> get props => [statusCode];
}

class WarningAlertEvent extends AlertEvent {
  final String message;

  const WarningAlertEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class InfoAlertEvent extends AlertEvent {
  final String message;

  const InfoAlertEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class ClearAlertEvent extends AlertEvent {
  const ClearAlertEvent();

  @override
  List<Object?> get props => [];
}
