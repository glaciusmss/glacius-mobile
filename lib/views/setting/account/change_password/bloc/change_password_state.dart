import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class InitialChangePasswordState extends ChangePasswordState {}

class ChangePasswordSubmitting extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordFailure extends ChangePasswordState {
  final Exception error;

  const ChangePasswordFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
