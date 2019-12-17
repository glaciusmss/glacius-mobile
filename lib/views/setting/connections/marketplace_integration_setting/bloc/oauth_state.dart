import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class OAuthState extends Equatable {
  const OAuthState();

  @override
  List<Object> get props => [];
}

class OAuthInitial extends OAuthState {}

class OAuthUpdating extends OAuthState {
  final String marketplace;

  const OAuthUpdating({@required this.marketplace});

  @override
  List<Object> get props => [marketplace];
}

class OAuthDisableSuccess extends OAuthState {}

class OAuthDisableFailure extends OAuthState {
  final Exception error;

  const OAuthDisableFailure({@required this.error});

  @override
  List<Object> get props => [error];
}

class OAuthGetConnectUrlLoading extends OAuthState {
  final String marketplace;

  const OAuthGetConnectUrlLoading({@required this.marketplace});

  @override
  List<Object> get props => [marketplace];
}

class OAuthGetConnectUrlSuccess extends OAuthState {
  final String url;

  const OAuthGetConnectUrlSuccess({@required this.url});

  @override
  List<Object> get props => [url];
}
