import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/views/login/bloc/bloc.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

class LoginButton extends StatefulWidget {
  final GlobalKey<FormBuilderState> _fbKey;
  final LoginBloc loginBloc;

  LoginButton({
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.loginBloc,
  }) : _fbKey = fbKey;

  @override
  _LoginButtonState createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  void _login() {
    if (widget._fbKey.currentState.saveAndValidate()) {
      Map<String, dynamic> formValue = widget._fbKey.currentState.value;
      widget.loginBloc.add(
        BtnLoginPressed(
          email: formValue['email'],
          password: formValue['password'],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(
                vertical: (state is LoginSubmitting) ? 10.0 : 20.0,
                horizontal: 20.0,
              ),
              primary: Theme.of(context).primaryColor,
            ),
            onPressed: (state is LoginSubmitting) ? null : _login,
            child: (state is LoginSubmitting)
                ? Spinner.configured(
                    context,
                    color: Colors.white,
                  )
                : Text(
                    "Log In",
                    style: TextStyle(color: Colors.white),
                  ),
          ),
        );
      },
    );
  }
}
