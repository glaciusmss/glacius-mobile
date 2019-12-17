import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';
import 'package:flutter/foundation.dart';

class ProductRepository {
  ProductApiService _productApiService;

  ProductRepository({ProductApiService productApiService}) {
    productApiService ??= ProductApiService();

    this._productApiService = productApiService;
  }

  Future<List<Product>> getProducts({@required int shopId}) async {
    List<dynamic> data = await this._productApiService.getProducts(
          shopId: shopId,
        );
    return data.map((model) => Product.fromJson(model)).toList();
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
