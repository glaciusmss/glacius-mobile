import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/setting/connections/notification_integration_setting/notification_integration_setting.dart';
import 'bloc/bloc.dart';

class NotificationIntegrationSettingPageBuilder extends StatelessWidget {
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
      child: NotificationIntegrationSettingPage(),
    );
  }
}
