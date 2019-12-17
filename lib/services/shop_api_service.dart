import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/utils/utils.dart';

class ShopApiService {
  Request _request;

  ShopApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<List<dynamic>> getMyShops() async {
    Response res = await this._request.client.get('/shop');

    return res.data;
  }

  Future<Map<String, dynamic>> createShop({@required Shop shop}) async {
    Response res =
        await this._request.client.post('/shop', data: shop.toJson());

    return res.data;
  }
}
