import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/marketplace_api_service.dart';

class MarketplaceRepository {
  MarketplaceApiService _marketplaceApiService;

  MarketplaceRepository({
    MarketplaceApiService marketplaceApiService,
  }) {
    marketplaceApiService ??= MarketplaceApiService();

    this._marketplaceApiService = marketplaceApiService;
  }

  Future<List<Marketplace>> getIntegrations({@required int shopId}) async {
    List<dynamic> data = await this
        ._marketplaceApiService
        .getMarketplaceIntegrations(shopId: shopId);

    return data.map((model) => Marketplace.fromJson(model)).toList();
  }
}
