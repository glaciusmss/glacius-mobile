import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NotificationChannelState extends Equatable {
  const NotificationChannelState();

  @override
  List<Object> get props => [];
}

class NotificationChannelInitial extends NotificationChannelState {}

class NotificationChannelUpdating extends NotificationChannelState {
  final String notificationChannel;

  const NotificationChannelUpdating({@required this.notificationChannel});

  @override
  List<Object> get props => [notificationChannel];
}

class NotificationChannelDisableSuccess extends NotificationChannelState {}

class NotificationChannelDisableFailure extends NotificationChannelState {
  final Exception error;

  const NotificationChannelDisableFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class NotificationChannelGetConnectUrlLoading extends NotificationChannelState {
  final String notificationChannel;

  const NotificationChannelGetConnectUrlLoading({
    @required this.notificationChannel,
  });

  @override
  List<Object> get props => [notificationChannel];
}

class NotificationChannelGetConnectUrlSuccess extends NotificationChannelState {
  final String url;

  const NotificationChannelGetConnectUrlSuccess({@required this.url});

  @override
  List<Object> get props => [url];
}
