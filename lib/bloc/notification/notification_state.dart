import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationReady extends NotificationState {
  final FirebaseMessaging firebaseMessaging;

  const NotificationReady({@required this.firebaseMessaging});

  @override
  List<Object> get props => [firebaseMessaging];
}

class NotificationReceived extends NotificationReady {
  final Map<String, dynamic> message;

  const NotificationReceived({
    @required FirebaseMessaging firebaseMessaging,
    @required this.message,
  }) : super(firebaseMessaging: firebaseMessaging);

  @override
  List<Object> get props => super.props..addAll([message]);
}
