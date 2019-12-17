import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

abstract class OAuthEvent extends Equatable {
  const OAuthEvent();

  @override
  List<Object> get props => [];
}

class DisconnectOAuth extends OAuthEvent {
  final String marketplace;

  const DisconnectOAuth({@required this.marketplace});

  @override
  List<Object> get props => [marketplace];
}

class ConnectOAuth extends OAuthEvent {
  final String marketplace;
  final Map data;

  const ConnectOAuth({@required this.marketplace, this.data});

  @override
  List<Object> get props => [marketplace, data];
}
