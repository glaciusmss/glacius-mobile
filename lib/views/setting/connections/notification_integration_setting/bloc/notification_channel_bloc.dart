import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import './bloc.dart';

class NotificationChannelBloc
    extends Bloc<NotificationChannelEvent, NotificationChannelState> {
  final NotificationRepository notificationRepository;

  NotificationChannelBloc({@required this.notificationRepository});

  @override
  NotificationChannelState get initialState => NotificationChannelInitial();

  @override
  Stream<NotificationChannelState> mapEventToState(
    NotificationChannelEvent event,
  ) async* {
    if (event is DisconnectChannel) {
      try {
        yield NotificationChannelUpdating(
          notificationChannel: event.notificationChannel,
        );
        await this.notificationRepository.disconnectChannel(
              notificationChannel: event.notificationChannel,
            );
        yield NotificationChannelDisableSuccess();
      } catch (error) {
        yield NotificationChannelDisableFailure(error: error);
      }
    }

    if (event is ConnectChannel) {
      yield NotificationChannelGetConnectUrlLoading(
        notificationChannel: event.notificationChannel,
      );
      String url = await this.notificationRepository.connectChannel(
            notificationChannel: event.notificationChannel,
          );
      yield NotificationChannelGetConnectUrlSuccess(url: url);
    }
  }
}
