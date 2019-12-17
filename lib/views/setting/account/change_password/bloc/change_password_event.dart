import 'package:equatable/equatable.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordAttempt extends ChangePasswordEvent {
  final String oldPassword;
  final String password;
  final String confirmPassword;

  const ChangePasswordAttempt({
    this.oldPassword,
    this.password,
    this.confirmPassword,
  });

  @override
  List<Object> get props => [oldPassword, password, confirmPassword];
}

class ResetChangePasswordBloc extends ChangePasswordEvent {}