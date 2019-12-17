import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';
import 'package:flutter/foundation.dart';

class ShopRepository {
  ShopApiService _shopApiService;

  ShopRepository({ShopApiService shopApiService}) {
    shopApiService ??= ShopApiService();

    this._shopApiService = shopApiService;
  }

  Future<List<Shop>> getMyShops() async {
    List<dynamic> data = await this._shopApiService.getMyShops();
    return data.map((model) => Shop.fromJson(model)).toList();
  }

  Future<Shop> createShop({@required Shop shop}) async {
    Map<String, dynamic> data = await this._shopApiService.createShop(
          shop: shop,
        );

    return Shop.fromJson(data);
  }
}
