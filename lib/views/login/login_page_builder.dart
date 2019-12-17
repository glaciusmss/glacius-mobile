import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/auth/auth.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/login/bloc/bloc.dart';
import 'package:glacius_mobile/views/login/login.dart';

class LoginPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) {
        return LoginBloc(
          authBloc: BlocProvider.of<AuthBloc>(context),
          userRepository: RepositoryProvider.of<UserRepository>(context),
        );
      },
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSubmitting) {
            //hide keyboard when submit
            FocusScope.of(context).unfocus();
          }
        },
        child: LoginPage(),
      ),
    );
  }
}
