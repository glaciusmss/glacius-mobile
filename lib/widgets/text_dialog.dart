import 'package:flutter/material.dart';

class TextDialog extends StatelessWidget {
  final Widget title;
  final String formLabel;
  final String formHint;
  final String formHelper;
  final Function(String) formValidator;
  final Function(String) onConfirmPressed;
  final Color confirmBtnColor;
  final String confirmBtnText;
  TextEditingController textEditingController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextDialog({
    @required this.title,
    String initialValue,
    @required this.formLabel,
    this.formHint,
    this.formHelper,
    this.formValidator,
    @required this.onConfirmPressed,
    this.confirmBtnColor,
    this.confirmBtnText = 'Submit',
  }) : textEditingController = TextEditingController(text: initialValue);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      title: title,
      content: Form(
        key: _formKey,
        autovalidate: true,
        child: TextFormField(
          controller: textEditingController,
          validator: formValidator != null
              ? formValidator
              : (value) => null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            labelText: formLabel,
            hintText: formHint,
            helperText: formHelper,
          ),
        ),
      ),
      actions: <Widget>[
        FlatButton(
          textColor: confirmBtnColor != null
              ? confirmBtnColor
              : Theme.of(context).primaryColor,
          child: Text(confirmBtnText),
          onPressed: () async {
            bool shouldClose = true;

            if (_formKey.currentState.validate()) {
              if (onConfirmPressed != null) {
                shouldClose = await onConfirmPressed(textEditingController.text);
              }

              if (shouldClose == true || shouldClose == null) {
                Navigator.of(context).pop();
              }
            }
          },
        )
      ],
    );
  }
}