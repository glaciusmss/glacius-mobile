import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';
import 'package:flutter/foundation.dart';

class OrderRepository {
  OrderApiService _orderApiService;

  OrderRepository({OrderApiService orderApiService}) {
    orderApiService ??= OrderApiService();

    this._orderApiService = orderApiService;
  }

  Future<PaginatedData> getOrders({@required int shopId, int page}) async {
    Map data = await this._orderApiService.getOrders(
          shopId: shopId,
          page: page,
        );
    return PaginatedData.fromJson(data);
  }
}
