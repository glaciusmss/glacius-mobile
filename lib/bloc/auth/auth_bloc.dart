import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/auth/auth.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:pedantic/pedantic.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserRepository userRepository;
  ShopBloc shopBloc;

  AuthBloc({@required this.shopBloc, @required this.userRepository});

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted) {
      final bool hasToken = await this.userRepository.hasToken();

      if (hasToken) {
        final String token = await this.userRepository.getToken();
        User user = await _afterAuthCheck(token: token);
        yield AuthAuthenticated(user: user, token: token);
      } else {
        yield AuthUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthLoading();
      await this.userRepository.persistToken(token: event.token);
      User user = await _afterAuthCheck(token: event.token);
      yield AuthAuthenticated(user: user, token: event.token);
    }

    if (event is LoggedOut) {
      yield AuthLoading();
      unawaited(this.userRepository.logout()); //fire and forget, not really important
      Request().removeTokenFromAuthHeader();
      await this.userRepository.deleteToken();
      this.shopBloc.add(ResetShopBloc());
      yield AuthUnauthenticated();
    }
  }

  Future<User> _afterAuthCheck({@required String token}) async {
    Request().setTokenToAuthHeader(token: token);
    return await this.userRepository.loadUser();
  }
}
