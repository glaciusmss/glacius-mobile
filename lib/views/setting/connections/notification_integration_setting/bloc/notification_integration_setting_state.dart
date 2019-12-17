import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class NotificationIntegrationSettingState extends Equatable {
  const NotificationIntegrationSettingState();

  @override
  List<Object> get props => [];
}

class NotificationIntegrationSettingInitial
    extends NotificationIntegrationSettingState {}

class NotificationIntegrationSettingLoading
    extends NotificationIntegrationSettingState {}

class NotificationIntegrationSettingLoaded
    extends NotificationIntegrationSettingState {
  final List<NotificationChannel> integrations;

  NotificationIntegrationSettingLoaded({@required this.integrations});

  @override
  List<Object> get props => [integrations];
}
