import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/mixin/mixin.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/setting/connections/widgets/widgets.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class NotificationIntegrationSettingPage extends StatefulWidget {
  @override
  _NotificationIntegrationSettingPageState createState() =>
      _NotificationIntegrationSettingPageState();
}

class _NotificationIntegrationSettingPageState
    extends State<NotificationIntegrationSettingPage> with UniversalLinkMixin {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<NotificationIntegrationSettingBloc>(context)
        .add(LoadNotificationIntegrations());
  }

  @override
  void onUniversalLinkCallback(Uri uri) {
    BlocProvider.of<NotificationIntegrationSettingBloc>(context)
        .add(LoadNotificationIntegrations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationChannelBloc, NotificationChannelState>(
      listener: (context, state) {
        if (state is NotificationChannelDisableSuccess) {
          BlocProvider.of<NotificationIntegrationSettingBloc>(context)
              .add(LoadNotificationIntegrations());
        }

        if (state is NotificationChannelGetConnectUrlSuccess) {
          //start in browser
          OAuthHelper(
            browser: OAuthBrowser(onClosedCallback: () {
              BlocProvider.of<NotificationIntegrationSettingBloc>(context)
                  .add(LoadNotificationIntegrations());
            }),
          ).connect(state.url);
        }
      },
      child: BlocBuilder<NotificationIntegrationSettingBloc,
          NotificationIntegrationSettingState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: Text('Notification Connection')),
            body: Container(
              margin: EdgeInsets.all(10.0),
              child: (state is NotificationIntegrationSettingLoaded)
                  ? Column(
                      children: <Widget>[
                        ListTile(
                          title: Text('Telegram'),
                          trailing: EnableDisableButton(
                            integrations: state.integrations,
                            notificationChannel: 'telegram',
                          ),
                        ),
                      ],
                    )
                  : ConnectionSkeletonLoader(count: 1),
            ),
          );
        },
      ),
    );
  }
}
