import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/setting/account/change_password/widgets/widgets.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

import 'bloc/bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  final ChangePasswordBloc changePasswordBloc;

  ChangePasswordPage({@required this.changePasswordBloc});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  //password controller is use to compare with confirm password
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
      builder: (context, state) {
        return LoadingOverlay(
          show: (state is ChangePasswordSubmitting),
          child: Scaffold(
            appBar: AppBar(
              leading: CloseButton(),
              title: Text('Change Password'),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _changePasswordAttempt,
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(20.0),
              child: FormBuilder(
                key: _fbKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  children: <Widget>[
                    _oldPasswordField(),
                    SizedBox(height: 15.0),
                    _newPasswordField(),
                    SizedBox(height: 15.0),
                    _confirmNewPasswordField(),
                    SizedBox(height: 15.0),
                    if (state is ChangePasswordFailure)
                      ErrorPanel(
                        errorTxt: state.error.toString(),
                        onDismissed: () {
                          widget.changePasswordBloc
                              .add(ResetChangePasswordBloc());
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _confirmNewPasswordField() {
    return PasswordField(
      attribute: 'confirm_password',
      requiredErrorText: 'Confirm password field cannot be empty',
      labelText: 'Confirm New Password',
      hintText: 'Enter your new password again.',
      validators: [
        ExtendedFormBuilderValidators.confirmPassword(
          passwordController: _passwordController,
        ),
      ],
    );
  }

  Widget _newPasswordField() {
    return PasswordField(
      attribute: 'password',
      requiredErrorText: 'New password field cannot be empty',
      labelText: 'New Password',
      hintText: 'Enter your new password.',
      controller: _passwordController,
    );
  }

  Widget _oldPasswordField() {
    return PasswordField(
      attribute: 'old_password',
      requiredErrorText: 'Current password field cannot be empty',
      labelText: 'Current Password',
      hintText: 'Enter your current password.',
    );
  }

  void _changePasswordAttempt() {
    if (_fbKey.currentState.saveAndValidate()) {
      widget.changePasswordBloc.add(
        ChangePasswordAttempt(
          oldPassword: _fbKey.currentState.value['old_password'],
          password: _fbKey.currentState.value['password'],
          confirmPassword: _fbKey.currentState.value['confirm_password'],
        ),
      );
    }
  }
}
