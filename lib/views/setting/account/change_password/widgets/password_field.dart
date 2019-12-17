import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class PasswordField extends StatefulWidget {
  final String attribute;
  final String labelText;
  final String hintText;
  final String requiredErrorText;
  final TextEditingController controller;
  final List<FormFieldValidator> validators;

  PasswordField({
    @required this.attribute,
    @required this.labelText,
    this.hintText,
    this.requiredErrorText = 'This field cannot be empty.',
    this.controller,
    this.validators,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool isPasswordFieldHidden = true;
  List<FormFieldValidator> _mergedValidators;

  _showOrHidePasswordField() {
    setState(() {
      isPasswordFieldHidden = !isPasswordFieldHidden;
    });
  }

  @override
  void initState() {
    super.initState();

    _mergedValidators = [
      FormBuilderValidators.required(
        errorText: widget.requiredErrorText,
      )
    ];

    if (widget.validators != null) {
      _mergedValidators.addAll(widget.validators);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      attribute: widget.attribute,
      controller: widget.controller,
      validators: _mergedValidators,
      maxLines: 1,
      obscureText: isPasswordFieldHidden,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(15.0),
        border: OutlineInputBorder(),
        labelText: widget.labelText,
        hintText: widget.hintText,
        suffixIcon: IconButton(
          onPressed: _showOrHidePasswordField,
          icon: Icon(
            isPasswordFieldHidden ? Icons.visibility : Icons.visibility_off,
          ),
        ),
      ),
    );
  }
}
