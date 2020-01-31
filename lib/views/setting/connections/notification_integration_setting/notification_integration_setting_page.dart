import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/mixin/mixin.dart';
import 'package:shimmer/shimmer.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class NotificationIntegrationSettingPage extends StatefulWidget {
  final NotificationIntegrationSettingBloc notificationIntegrationSettingBloc;
  final NotificationChannelBloc notificationChannelBloc;

  const NotificationIntegrationSettingPage({
    @required this.notificationIntegrationSettingBloc,
    @required this.notificationChannelBloc,
  });

  @override
  _NotificationIntegrationSettingPageState createState() =>
      _NotificationIntegrationSettingPageState();
}

class _NotificationIntegrationSettingPageState
    extends State<NotificationIntegrationSettingPage> with UniversalLinkMixin {
  @override
  void initState() {
    super.initState();

    widget.notificationIntegrationSettingBloc.add(
      LoadNotificationIntegrations(),
    );
  }

  @override
  void onUniversalLinkCallback(Uri uri) {
    widget.notificationIntegrationSettingBloc.add(
      LoadNotificationIntegrations(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationIntegrationSettingBloc,
        NotificationIntegrationSettingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Notification Connection')),
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Telegram'),
                  trailing: (state is NotificationIntegrationSettingLoaded)
                      ? EnableDisableButton(
                          notificationChannelBloc:
                              widget.notificationChannelBloc,
                          integrations: state.integrations,
                          notificationChannel: 'telegram',
                        )
                      : _skeletonButton(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _skeletonButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: 35.0,
        width: 90.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
        ),
      ),
    );
  }
}
