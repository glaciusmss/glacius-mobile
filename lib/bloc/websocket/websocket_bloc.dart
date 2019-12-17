import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_pusher_client/flutter_pusher.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/bloc/websocket/websocket.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:laravel_echo/laravel_echo.dart';
import './websocket.dart';

class WebsocketBloc extends Bloc<WebsocketEvent, WebsocketState> {
  AuthBloc authBloc;
  ShopBloc shopBloc;

  WebsocketBloc({@required this.authBloc, @required this.shopBloc});

  @override
  WebsocketState get initialState => WebsocketInitial();

  @override
  Stream<WebsocketState> mapEventToState(WebsocketEvent event) async* {
    if (event is SetupEcho) {
      yield WebsocketReady(
        echo: EchoHelper(
          token: (authBloc.state as AuthAuthenticated).token,
        ).client,
      );
    }

    if (event is ConnectPrivateChannel) {
      if (state is WebsocketReady) {
        Echo echo = (state as WebsocketReady).echo;
        echo.private(event.channelName).notification((Event notification) {
          event.notificationListener(jsonDecode(notification.data));
        });
      }
    }

    if (event is LeaveChannel) {
      if (state is WebsocketReady) {
        (state as WebsocketReady).echo.leave(event.channelName);
      }
    }
  }
}
