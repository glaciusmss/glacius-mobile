import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'bloc/bloc.dart';
import 'change_password_page.dart';

class ChangePasswordPageBuilder extends StatelessWidget {
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
    return BlocProvider<ChangePasswordBloc>(
      create: (context) {
        return ChangePasswordBloc(
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
    return BlocListener<ChangePasswordBloc, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSubmitting) {
          //hide keyboard when submit
          FocusScope.of(context).unfocus();
        }

        if (state is ChangePasswordSuccess) {
          Navigator.of(context).pop('Password has been changed');
        }
      },
      child: child,
    );
  }
}

class _InjectBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangePasswordPage(
      changePasswordBloc: BlocProvider.of<ChangePasswordBloc>(context),
    );
  }
}
