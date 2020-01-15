import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/utils/utils.dart';

class OrderApiService {
  Request _request;

  OrderApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<Map<String, dynamic>> getOrders({
    @required int shopId,
    int page = 1,
  }) async {
    Response res = await this._request.client.get(
      '/order',
      queryParameters: {'shop_id': shopId, 'page': page},
    );

    return res.data;
  }
}
