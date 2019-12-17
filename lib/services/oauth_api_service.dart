import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/utils/utils.dart';

class OAuthApiService {
  Request _request;

  OAuthApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<dynamic> connectOAuth({
    @required String marketplace,
    @required int shopId,
    Map data,
  }) async {
    Response res = await this._request.client.post(
          '/$marketplace/oauth',
          queryParameters: {'shop_id': shopId},
          data: data,
        );

    return res.data;
  }

  Future<dynamic> deleteOAuth({
    @required String marketplace,
    @required int shopId,
  }) async {
    return await this._request.client.delete(
      '/$marketplace/oauth',
      data: {'shop_id': shopId},
    );
  }
}
