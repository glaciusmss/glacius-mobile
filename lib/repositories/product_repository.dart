import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';
import 'package:flutter/foundation.dart';

class ProductRepository {
  ProductApiService _productApiService;

  ProductRepository({ProductApiService productApiService}) {
    productApiService ??= ProductApiService();

    this._productApiService = productApiService;
  }

  Future<PaginatedData> getProducts({@required int shopId, int page}) async {
    Map data = await this._productApiService.getProducts(
          shopId: shopId,
          page: page,
        );
    return PaginatedData.fromJson(data);
  }

  Future<void> createProduct({
    @required int shopId,
    @required Product product,
  }) async {
    return await this
        ._productApiService
        .createProduct(shopId: shopId, product: product);
  }

  Future<void> updateProduct({
    @required int shopId,
    @required Product product,
  }) async {
    return await this
        ._productApiService
        .updateProduct(shopId: shopId, product: product);
  }
}
