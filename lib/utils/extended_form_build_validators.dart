import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class ExtendedFormBuilderValidators extends FormBuilderValidators {
  static FormFieldValidator confirmPassword({
    @required TextEditingController passwordController,
    String errorText = "Confirm password must match with new password.",
  }) {
    return (valueCandidate) {
      if (valueCandidate != passwordController.text) {
        return errorText;
      }
      return null;
    };
  }
}
