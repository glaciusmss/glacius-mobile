import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/views/login/bloc/bloc.dart';

class PasswordField extends StatefulWidget {
  final GlobalKey<FormBuilderState> _fbKey;
  final LoginBloc loginBloc;

  PasswordField({
    @required GlobalKey<FormBuilderState> fbKey,
    @required this.loginBloc,
  }) : _fbKey = fbKey;

  @override
  State<StatefulWidget> createState() => _PasswordField();
}

class _PasswordField extends State<PasswordField> {
  bool isPasswordFieldHidden = true;

  _showOrHidePasswordField() {
    setState(() {
      isPasswordFieldHidden = !isPasswordFieldHidden;
    });
  }

  _showErrorText(state) {
    if (state is LoginFailure) {
      return state.error.toString();
    }

    return widget
        ._fbKey.currentState.fields['password']?.currentState?.errorText;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FormBuilderTextField(
          attribute: 'password',
          validators: [
            FormBuilderValidators.required(
              errorText: 'Password field cannot be empty',
            ),
          ],
          onChanged: (value) {
            if (state is LoginFailure) {
              widget.loginBloc.add(ResetLoginBloc());
            }
          },
          maxLines: 1,
          obscureText: isPasswordFieldHidden,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            errorText: _showErrorText(state),
            contentPadding: EdgeInsets.all(15.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            prefixIcon: Icon(
              Icons.lock_outline,
              color: Colors.black,
            ),
            suffixIcon: IconButton(
              onPressed: _showOrHidePasswordField,
              icon: Icon(
                isPasswordFieldHidden ? Icons.visibility : Icons.visibility_off,
              ),
            ),
          ),
        );
      },
    );
  }
}
