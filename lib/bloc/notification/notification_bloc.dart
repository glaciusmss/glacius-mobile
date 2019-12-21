import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:pedantic/pedantic.dart';
import './notification.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  ShopBloc shopBloc;

  NotificationBloc({@required this.shopBloc});

  @override
  NotificationState get initialState => NotificationInitial();

  @override
  Stream<NotificationState> mapEventToState(NotificationEvent event) async* {
    if (event is SetupFirebaseMessaging) {
      FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

      unawaited(
        _firebaseMessaging.getToken().then((String token) {
          print('firebase token: ' + token);
        }),
      );

      _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          add(CallbackEvent(message: message, type: CallbackType.onMessage));
        },
        onResume: (Map<String, dynamic> message) async {
          add(CallbackEvent(message: message, type: CallbackType.onResume));
        },
        onLaunch: (Map<String, dynamic> message) async {
          add(CallbackEvent(message: message, type: CallbackType.onLaunch));
        },
      );

      unawaited(
        _firebaseMessaging.subscribeToTopic(
          'App.Shop.' + shopBloc.getMyShop().id.toString(),
        ),
      );

      yield NotificationReady(firebaseMessaging: _firebaseMessaging);
    }

    if (event is CallbackEvent) {
      if (state is NotificationReady) {
        yield NotificationReceived(
          firebaseMessaging: (state as NotificationReady).firebaseMessaging,
          message: event.message,
        );
      }
    }

    if (event is LeaveTopic) {
      if (state is NotificationReady) {
        await (state as NotificationReady)
            .firebaseMessaging
            .unsubscribeFromTopic(
              'App.Shop.' + event.shop.id.toString(),
            );
      }
    }
  }
}
