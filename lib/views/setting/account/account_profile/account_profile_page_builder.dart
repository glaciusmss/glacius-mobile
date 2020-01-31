import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';

import 'account_profile.dart';
import 'package:flutter/material.dart';

import 'bloc/bloc.dart';

class AccountProfilePageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BindBlocProvider(
      child: _InjectBlocListener(
        child: _InjectBlocProvider(),
      ),
    );
  }
}

class _BindBlocProvider extends StatelessWidget {
  final Widget child;

  _BindBlocProvider({this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountProfileBloc>(
      create: (context) {
        return AccountProfileBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        );
      },
      child: child,
    );
  }
}

class _InjectBlocListener extends StatelessWidget {
  final Widget child;

  _InjectBlocListener({this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _InjectBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AccountProfilePage(
      accountProfileBloc: BlocProvider.of<AccountProfileBloc>(context),
    );
  }
}
