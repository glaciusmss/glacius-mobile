import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class NotificationChannelEvent extends Equatable {
  const NotificationChannelEvent();

  @override
  List<Object> get props => [];
}

class DisconnectChannel extends NotificationChannelEvent {
  final String notificationChannel;

  const DisconnectChannel({@required this.notificationChannel});

  @override
  List<Object> get props => [notificationChannel];
}

class ConnectChannel extends NotificationChannelEvent {
  final String notificationChannel;

  const ConnectChannel({@required this.notificationChannel});

  @override
  List<Object> get props => [notificationChannel];
}
