import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import './bloc.dart';

class NotificationIntegrationSettingBloc extends Bloc<
    NotificationIntegrationSettingEvent, NotificationIntegrationSettingState> {
  final NotificationRepository notificationRepository;

  NotificationIntegrationSettingBloc({@required this.notificationRepository});

  @override
  NotificationIntegrationSettingState get initialState =>
      NotificationIntegrationSettingInitial();

  @override
  Stream<NotificationIntegrationSettingState> mapEventToState(
    NotificationIntegrationSettingEvent event,
  ) async* {
    if (event is LoadNotificationIntegrations) {
      yield NotificationIntegrationSettingLoading();
      List<NotificationChannel> notificationIntegrations =
          await this.notificationRepository.getChannelIntegrations();
      yield NotificationIntegrationSettingLoaded(
        integrations: notificationIntegrations,
      );
    }
  }
}
