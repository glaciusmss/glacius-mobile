import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/config/config.dart';
import 'package:glacius_mobile/views/login/bloc/bloc.dart';
import 'package:glacius_mobile/views/login/widgets/login_button.dart';
import 'package:glacius_mobile/widgets/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc loginBloc;

  const LoginPage({@required this.loginBloc});

  @override
  State createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  showDialog(
                    context: context,
                    child: TextDialog(
                      title: Text('Self-hosted setting'),
                      initialValue: Application.baseUrl,
                      formLabel: 'Server URL',
                      formHint: 'ex. https://glaciuscore.com',
                      formHelper: 'Enter the Server URL of your installation',
                      onConfirmPressed: (String value) async {
                        var sp = await SharedPreferences.getInstance();
                        await sp.setString(
                          "APP_URL",
                          StringUtils.isNullOrEmpty(value) ? null : value,
                        );
                        await Application.loadBaseUrlFromSP();
                      },
                    ),
                  );
                },
              )
            ],
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            child: FormBuilder(
              initialValue: {
                'email': DotEnv().env['DEV_EMAIL'],
                'password': DotEnv().env['DEV_PASS'],
              },
              key: _fbKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 65.0, bottom: 50.0),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 128.0,
                            width: 128.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.black,
                              radius: 100.0,
                              child: Text(
                                "G",
                                style: TextStyle(
                                  fontSize: 50.0,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'Glacius MSS',
                              style: TextStyle(color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  EmailField(),
                  SizedBox(height: 10.0),
                  PasswordField(
                      fbKey: _fbKey,
                      loginBloc: BlocProvider.of<LoginBloc>(context)),
                  SizedBox(height: 30.0),
                  LoginButton(
                      fbKey: _fbKey,
                      loginBloc: BlocProvider.of<LoginBloc>(context)),
                  SizedBox(height: 10.0),
                  SizedBox(
                    width: double.infinity,
                    child: FlatButton(
                      padding: EdgeInsets.all(20.0),
                      color: Colors.transparent,
                      onPressed: () => {},
                      child: Text(
                        "Forget your password?",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Divider(color: Colors.blueGrey),
          SizedBox(height: 10.0),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40.0),
            child: FlatButton(
              padding: EdgeInsets.all(20.0),
              color: Colors.transparent,
              onPressed: () => {},
              child: Text(
                'Don\'t have an account? Create One',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
