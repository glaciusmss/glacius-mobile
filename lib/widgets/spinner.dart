import 'package:flutter/material.dart';

class Spinner {
  static Widget withScaffold(context) {
    return Scaffold(
      body: Spinner.configured(context),
    );
  }

  static Widget configured(
    context, {
    double value,
    Color color,
    Color backgroundColor,
    double lineWidth = 4.0,
  }) {
    return Center(
      child: CircularProgressIndicator(
        value: value,
        valueColor: AlwaysStoppedAnimation(
          color ?? Theme.of(context).indicatorColor,
        ),
        backgroundColor: backgroundColor,
        strokeWidth: lineWidth,
      ),
    );
  }
}
