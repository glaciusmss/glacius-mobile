import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EmailField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      attribute: "email",
      validators: [
        FormBuilderValidators.required(
          errorText: 'Email field cannot be empty',
        ),
        FormBuilderValidators.email(),
      ],
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.black,
        ),
      ),
    );
  }
}
