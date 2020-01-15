import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/utils/utils.dart';

class ProductApiService {
  Request _request;

  ProductApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<Map<String, dynamic>> getProducts({
    @required int shopId,
    int page = 1,
  }) async {
    Response res = await this._request.client.get(
      '/product',
      queryParameters: {'shop_id': shopId, 'page': page},
    );

    return res.data;
  }

  Future<void> createProduct({
    @required int shopId,
    @required Product product,
  }) async {
    return await this._request.client.post(
          '/product',
          queryParameters: {'shop_id': shopId},
          data: product.toJson(),
        );
  }

  Future<void> updateProduct({
    @required int shopId,
    @required Product product,
  }) async {
    return await this._request.client.patch(
          '/product/' + product.id.toString(),
          queryParameters: {'shop_id': shopId},
          data: product.toJson(),
        );
  }
}
