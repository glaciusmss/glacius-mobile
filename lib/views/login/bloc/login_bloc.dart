import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/auth/auth.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/login/bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthBloc authBloc;

  LoginBloc({@required this.authBloc, @required this.userRepository});

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is BtnLoginPressed) {
      yield* this._mapBtnLoginPressedToState(
        email: event.email,
        password: event.password,
      );
    }

    if (event is ResetLoginBloc) {
      yield LoginInitial();
    }
  }

  Stream<LoginState> _mapBtnLoginPressedToState({
    String email,
    String password,
  }) async* {
    yield LoginSubmitting();
    try {
      String token = await this.userRepository.login(
            email: email,
            password: password,
          );
      this.authBloc.add(LoggedIn(token: token));
      yield LoginSuccess();
    } catch (error) {
      yield LoginFailure(error: error);
    }
  }
}
