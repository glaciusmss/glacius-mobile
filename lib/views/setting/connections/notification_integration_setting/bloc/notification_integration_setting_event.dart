import 'package:equatable/equatable.dart';

abstract class NotificationIntegrationSettingEvent extends Equatable {
  const NotificationIntegrationSettingEvent();

  @override
  List<Object> get props => [];
}

class LoadNotificationIntegrations extends NotificationIntegrationSettingEvent {
}
