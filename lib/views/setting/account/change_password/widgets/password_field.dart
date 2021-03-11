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
  List<FormFieldValidator> mergedValidators;

  _showOrHidePasswordField() {
    setState(() {
      isPasswordFieldHidden = !isPasswordFieldHidden;
    });
  }

  @override
  void initState() {
    super.initState();

    mergedValidators = [
      FormBuilderValidators.required(
        context,
        errorText: widget.requiredErrorText,
      )
    ];

    if (widget.validators != null) {
      mergedValidators.addAll(widget.validators);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      name: widget.attribute,
      controller: widget.controller,
      validator: FormBuilderValidators.compose(mergedValidators),
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
