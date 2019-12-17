import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class WebsocketEvent extends Equatable {
  const WebsocketEvent();

  @override
  List<Object> get props => [];
}

class SetupEcho extends WebsocketEvent {}

class ConnectPrivateChannel extends WebsocketEvent {
  final String channelName;
  final Function(Map<String, dynamic> data) notificationListener;

  const ConnectPrivateChannel({
    @required this.channelName,
    @required this.notificationListener,
  });

  @override
  List<Object> get props => [channelName, notificationListener];
}

class LeaveChannel extends WebsocketEvent {
  final String channelName;

  const LeaveChannel({@required this.channelName});

  @override
  List<Object> get props => [channelName];
}
