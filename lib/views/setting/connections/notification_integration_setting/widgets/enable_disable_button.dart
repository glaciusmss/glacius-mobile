import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/views/setting/connections/notification_integration_setting/bloc/bloc.dart';
import 'package:glacius_mobile/widgets/widgets.dart';

class EnableDisableButton extends StatefulWidget {
  final List<NotificationChannel> integrations;
  final String notificationChannel;

  EnableDisableButton({
    @required this.integrations,
    @required this.notificationChannel,
  });

  @override
  _EnableDisableButtonState createState() => _EnableDisableButtonState();
}

class _EnableDisableButtonState extends State<EnableDisableButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationChannelBloc, NotificationChannelState>(
      listener: (context, state) {
        if (state is NotificationChannelUpdating) {
          if (widget.notificationChannel == state.notificationChannel) {
            this.setState(() {
              isLoading = true;
            });
          }
        }
      },
      child: BlocBuilder<NotificationChannelBloc, NotificationChannelState>(
        builder: (context, state) {
          return RaisedButton(
            color: _isNotificationChannelEnabled()
                ? Theme.of(context).errorColor
                : null,
            onPressed:
                (state is NotificationChannelUpdating) ? null : _onPressed,
            child: buttonText(context),
          );
        },
      ),
    );
  }

  Widget buttonText(context) {
    if (isLoading == true) {
      return SizedBox(
        height: 20.0,
        width: 20.0,
        child: Spinner.configured(
          context,
          color: Colors.white,
          lineWidth: 2.0,
        ),
      );
    }

    if (_isNotificationChannelEnabled()) {
      return Text(
        'Disable',
        style: TextStyle(color: Colors.white),
      );
    }

    return Text('Enable');
  }

  bool _isNotificationChannelEnabled() {
    var integrations = widget.integrations
        .where((integration) => integration.name == widget.notificationChannel);

    return integrations.isNotEmpty;
  }

  void _onPressed() {
    final notificationChannelBloc = BlocProvider.of<NotificationChannelBloc>(
      context,
    );

    if (_isNotificationChannelEnabled()) {
      //this is disable action
      showDialog(
        context: context,
        builder: (context) {
          return ConfirmDialog(
            content: Text(
              'You will be disconnect from ' +
                  StringUtils.capitalize(widget.notificationChannel),
            ),
            confirmBtnColor: Theme.of(context).errorColor,
            confirmBtnText: 'Disable',
            onConfirmPressed: () {
              notificationChannelBloc.add(
                DisconnectChannel(
                  notificationChannel: widget.notificationChannel,
                ),
              );
            },
          );
        },
      );
    } else {
      notificationChannelBloc.add(ConnectChannel(
        notificationChannel: widget.notificationChannel,
      ));
    }
  }
}
