import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class BtnLoginPressed extends LoginEvent {
  final String email;
  final String password;

  const BtnLoginPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class ResetLoginBloc extends LoginEvent {}
