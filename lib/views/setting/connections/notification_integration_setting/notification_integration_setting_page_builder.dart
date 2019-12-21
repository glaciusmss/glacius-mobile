import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/setting/connections/notification_integration_setting/notification_integration_setting.dart';
import 'bloc/bloc.dart';

class NotificationIntegrationSettingPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BindBlocProvider(
      child: _InjectBlocListener(
        child: _InjectBlocProvider(),
      ),
    );
  }
}

class _BindBlocProvider extends StatelessWidget {
  final Widget child;

  _BindBlocProvider({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationIntegrationSettingBloc>(
          create: (context) {
            return NotificationIntegrationSettingBloc(
              notificationRepository:
                  RepositoryProvider.of<NotificationRepository>(context),
            );
          },
        ),
        BlocProvider<NotificationChannelBloc>(
          create: (context) {
            return NotificationChannelBloc(
              notificationRepository:
                  RepositoryProvider.of<NotificationRepository>(context),
            );
          },
        )
      ],
      child: child,
    );
  }
}

class _InjectBlocListener extends StatelessWidget {
  final Widget child;

  _InjectBlocListener({this.child});

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
      child: child,
    );
  }
}

class _InjectBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationIntegrationSettingPage(
      notificationChannelBloc:
          BlocProvider.of<NotificationChannelBloc>(context),
      notificationIntegrationSettingBloc:
          BlocProvider.of<NotificationIntegrationSettingBloc>(context),
    );
  }
}
