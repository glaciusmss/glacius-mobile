import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/setting/account/account_profile/account_profile.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

import 'bloc/bloc.dart';

class AccountProfilePage extends StatefulWidget {
  final AccountProfileBloc accountProfileBloc;

  AccountProfilePage({@required this.accountProfileBloc});

  @override
  _AccountProfilePageState createState() => _AccountProfilePageState();
}

class _AccountProfilePageState extends State<AccountProfilePage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    widget.accountProfileBloc.add(LoadAccountProfile());
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    return BlocBuilder<AccountProfileBloc, AccountProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: CloseButton(),
            title: Text('Account Profile'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.check),
                onPressed: () {
                  _onSavePressed(state);
                },
              )
            ],
          ),
          body: Builder(
            builder: (context) {
              if (state is AccountProfileLoaded) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.all(20.0),
                  child: FormBuilder(
                    key: _fbKey,
                    autovalidateMode: AutovalidateMode.always,
                    initialValue: {
                      FormAttribute.phone: state.userProfile.phoneNumber,
                      FormAttribute.dob: state.userProfile.dateOfBirth != null
                          ? DateTime.parse(
                              state.userProfile.dateOfBirth,
                            )
                          : DateTime(now.year - 18, now.month, now.day),
                      //18 years
                      FormAttribute.gender: state.userProfile.gender,
                    },
                    child: Column(
                      children: <Widget>[
                        if (state is AccountProfileFailure)
                          ErrorPanel(errorTxt: state.error.toString()),
                        SizedBox(height: 15.0),
                        FormBuilderTextField(
                          name: FormAttribute.phone,
                          maxLines: 1,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15.0),
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            hintText: 'Enter your phone number',
                          ),
                        ),
                        SizedBox(height: 15.0),
                        // FormBuilderDateTimePicker(
                        //   attribute: FormAttribute.dob,
                        //   inputType: InputType.date,
                        //   format: DateFormat('yyyy-MM-dd'),
                        //   lastDate: DateTime(now.year - 18, now.month, now.day),
                        //   resetIcon: null,
                        //   decoration: InputDecoration(
                        //     contentPadding: EdgeInsets.all(15.0),
                        //     border: OutlineInputBorder(),
                        //     labelText: 'Birthday',
                        //   ),
                        // ),
                        // SizedBox(height: 15.0),
                        FormBuilderSegmentedControl(
                          name: FormAttribute.gender,
                          pressedColor:
                              Theme.of(context).primaryColor.withOpacity(0.2),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Gender',
                          ),
                          options: <FormBuilderFieldOption>[
                            FormBuilderFieldOption(value: '0', child: Text('Male')),
                            FormBuilderFieldOption(value: '1', child: Text('Female')),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }
              return Spinner.withScaffold(context);
            },
          ),
        );
      },
    );
  }

  void _onSavePressed(AccountProfileLoaded state) {
    if (_fbKey.currentState.saveAndValidate()) {
      Map<String, dynamic> formValue = _fbKey.currentState.value;
      UserProfile userProfile = UserProfile(
        id: state.userProfile.id,
        phoneNumber: Helper.ifEmptyToNull(FormAttribute.phone),
        dateOfBirth: formValue[FormAttribute.dob],
        gender: formValue[FormAttribute.gender],
      );

      widget.accountProfileBloc.add(
        UpdateAccountProfile(userProfile: userProfile),
      );
    }
  }
}
