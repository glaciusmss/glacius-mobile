import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/views/login/widgets/login_button.dart';

import 'widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  State createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        initialValue: {
          'email': DotEnv().env['DEV_EMAIL'],
          'password': DotEnv().env['DEV_PASS'],
        },
        key: _fbKey,
        autovalidate: true,
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40.0),
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
                  PasswordField(fbKey: _fbKey),
                  SizedBox(height: 30.0),
                  LoginButton(fbKey: _fbKey),
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
      ),
    );
  }
}
