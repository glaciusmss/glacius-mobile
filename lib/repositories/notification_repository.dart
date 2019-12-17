import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';

class NotificationRepository {
  NotificationApiService _notificationApiService;

  NotificationRepository({
    NotificationApiService notificationApiService,
  }) {
    notificationApiService ??= NotificationApiService();

    this._notificationApiService = notificationApiService;
  }

  Future<List<NotificationChannel>> getChannelIntegrations() async {
    List<dynamic> data =
        await this._notificationApiService.getChannelIntegrations();

    return data.map((model) => NotificationChannel.fromJson(model)).toList();
  }

  Future<String> connectChannel({@required String notificationChannel}) async {
    Map resData = await this._notificationApiService.connectChannel(
          notificationChannel: notificationChannel,
        );

    return resData['url'];
  }

  Future<dynamic> disconnectChannel({
    @required String notificationChannel,
  }) async {
    return await this._notificationApiService.disconnectChannel(
          notificationChannel: notificationChannel,
        );
  }
}
