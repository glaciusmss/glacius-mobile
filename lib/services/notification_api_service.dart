import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/utils/utils.dart';

class NotificationApiService {
  Request _request;

  NotificationApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<List<dynamic>> getChannelIntegrations() async {
    Response res = await this._request.client.get(
          '/notification',
        );

    return res.data;
  }

  Future<dynamic> connectChannel({@required String notificationChannel}) async {
    Response res = await this._request.client.post(
          '/notification/$notificationChannel',
        );

    return res.data;
  }

  Future<dynamic> disconnectChannel({
    @required String notificationChannel,
  }) async {
    return await this._request.client.delete(
          '/notification/$notificationChannel',
        );
  }
}
