import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'bloc/bloc.dart';
import 'change_password_page.dart';

class ChangePasswordPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
      create: (context) {
        return ChangePasswordBloc(
          userRepository: RepositoryProvider.of<UserRepository>(context),
        );
      },
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSubmitting) {
            //hide keyboard when submit
            FocusScope.of(context).unfocus();
          }

          if (state is ChangePasswordSuccess) {
            Navigator.of(context).pop('Password has been changed');
          }
        },
        child: ChangePasswordPage(),
      ),
    );
  }
}
