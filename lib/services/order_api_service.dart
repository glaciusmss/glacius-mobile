import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/utils/utils.dart';

class OrderApiService {
  Request _request;

  OrderApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<List<dynamic>> getOrders({@required int shopId}) async {
    Response res = await this._request.client.get(
      '/order',
      queryParameters: {'shop_id': shopId},
    );

    return res.data;
  }
}
