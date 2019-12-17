import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginSubmitting extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final Exception error;

  const LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
