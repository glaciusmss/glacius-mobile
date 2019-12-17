import 'package:dio/dio.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:flutter/foundation.dart';

class MarketplaceApiService {
  Request _request;

  MarketplaceApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<List<dynamic>> getMarketplaceIntegrations({@required int shopId}) async {
    Response res = await this._request.client.get(
      '/marketplace-integration',
      queryParameters: {'shop_id': shopId},
    );

    return res.data;
  }
}
