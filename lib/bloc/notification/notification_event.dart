import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:glacius_mobile/models/models.dart';

enum CallbackType { onMessage, onBackgroundMessage, onResume, onLaunch }

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class SetupFirebaseMessaging extends NotificationEvent {}

class CallbackEvent extends NotificationEvent {
  final Map<String, dynamic> message;
  final CallbackType type;

  const CallbackEvent({@required this.message, @required this.type});

  @override
  List<Object> get props => [message, type];
}

class LeaveTopic extends NotificationEvent {
  final Shop shop;

  const LeaveTopic({@required this.shop});

  @override
  List<Object> get props => [shop];
}
