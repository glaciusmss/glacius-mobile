import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import './bloc.dart';
import 'package:flutter/foundation.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final UserRepository userRepository;

  ChangePasswordBloc({@required this.userRepository});

  @override
  ChangePasswordState get initialState => InitialChangePasswordState();

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is ResetChangePasswordBloc) {
      yield InitialChangePasswordState();
    }

    if (event is ChangePasswordAttempt) {
      yield ChangePasswordSubmitting();
      try {
        await this.userRepository.changePassword(
              oldPassword: event.oldPassword,
              password: event.password,
              confirmPassword: event.confirmPassword,
            );
        yield ChangePasswordSuccess();
      } catch (error) {
        yield ChangePasswordFailure(error: error);
      }
    }
  }
}
