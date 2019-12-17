import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';

class ErrorPanel extends StatefulWidget {
  final String errorTxt;
  final bool show;
  final VoidCallback onDismissed;

  ErrorPanel({
    @required this.errorTxt,
    this.show,
    this.onDismissed,
  });

  @override
  _ErrorPanelState createState() => _ErrorPanelState();
}

class _ErrorPanelState extends State<ErrorPanel>
    with SingleTickerProviderStateMixin {
  bool _shouldShow;
  AnimationController _animationController;
  Animation _animation;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    setState(() {
      _shouldShow = widget.show ?? true;
    });

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _animation = Tween(
      begin: 1.0,
      end: 0.0,
    ).animate(_curvedAnimation);

    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //hide the panel
        setState(() {
          _shouldShow = false;
        });
        //callback to parent if necessary
        if (widget.onDismissed != null) {
          widget.onDismissed();
        }
      }
    });
  }

  void _onCloseBtnPressed() {
    //start fade out animation
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    if (!_shouldShow) {
      return SizedBox.shrink();
    }

    return FadeTransition(
      opacity: _animation,
      child: Material(
        color: Theme.of(context).errorColor,
        borderRadius: BorderRadius.all(
          Radius.circular(7.0),
        ),
        child: ListTile(
          leading: Icon(Icons.error, color: Colors.white),
          title: Text(
            StringUtils.capitalize(widget.errorTxt),
            style: TextStyle(color: Colors.white),
          ),
          trailing: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: _onCloseBtnPressed,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
