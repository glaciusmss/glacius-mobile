import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final Function onCancelPressed;
  final Function onConfirmPressed;
  final Color cancelBtnColor;
  final Color confirmBtnColor;
  final String cancelBtnText;
  final String confirmBtnText;

  ConfirmDialog({
    this.title = const Text('Confirmation'),
    @required this.content,
    this.onCancelPressed,
    @required this.onConfirmPressed,
    this.cancelBtnColor,
    this.confirmBtnColor,
    this.cancelBtnText = 'Cancel',
    this.confirmBtnText = 'Confirm',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      title: title,
      content: content,
      actions: <Widget>[
        TextButton(
          child: Text(
            cancelBtnText,
            style: TextStyle(
              color: cancelBtnColor != null
                  ? cancelBtnColor
                  : Theme.of(context).accentColor,
            ),
          ),
          onPressed: () {
            bool shouldClose = true;

            if (onCancelPressed != null) {
              shouldClose = onCancelPressed();
            }

            if (shouldClose == true || shouldClose == null) {
              Navigator.of(context).pop();
            }
          },
        ),
        TextButton(
          child: Text(
            confirmBtnText,
            style: TextStyle(
              color: confirmBtnColor != null
                  ? confirmBtnColor
                  : Theme.of(context).primaryColor,
            ),
          ),
          onPressed: () {
            bool shouldClose = true;

            if (onConfirmPressed != null) {
              shouldClose = onConfirmPressed();
            }

            if (shouldClose == true || shouldClose == null) {
              Navigator.of(context).pop();
            }
          },
        )
      ],
    );
  }
}
