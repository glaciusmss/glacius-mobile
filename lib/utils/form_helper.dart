import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

mixin FormHelper<T extends StatefulWidget> on State<T> {
  dynamic getFormValue(GlobalKey<FormBuilderState> form, String field) {
    if (form == null || form.currentState.fields.containsKey(field) == false) {
      return null;
    }

    return form.currentState.fields[field].currentState.value;
  }

  void setFormValue(
    GlobalKey<FormBuilderState> form,
    String field,
    dynamic value,
  ) {
    if (form == null || form.currentState.fields.containsKey(field) == false) {
      return;
    }

    setState(() {
      form.currentState.setAttributeValue(field, value);
    });
  }
}
