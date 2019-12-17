import 'package:flutter/material.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

class LoadingOverlay extends StatelessWidget {
  final bool show;
  final Widget child;

  LoadingOverlay({
    @required this.show,
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!this.show) {
      return child;
    }

    return Stack(
      children: <Widget>[
        child,
        Opacity(
          child: ModalBarrier(dismissible: false, color: Colors.grey),
          opacity: 0.5,
        ),
        Center(
          child: Spinner.configured(context),
        ),
      ],
    );
  }
}
