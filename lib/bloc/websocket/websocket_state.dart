import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:laravel_echo/laravel_echo.dart';

abstract class WebsocketState extends Equatable {
  const WebsocketState();

  @override
  List<Object> get props => [];
}

class WebsocketInitial extends WebsocketState {}

class WebsocketReady extends WebsocketState {
  final Echo echo;

  const WebsocketReady({@required this.echo});

  @override
  List<Object> get props => [echo];
}
