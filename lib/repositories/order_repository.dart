import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';
import 'package:flutter/foundation.dart';

class OrderRepository {
  OrderApiService _orderApiService;

  OrderRepository({OrderApiService orderApiService}) {
    orderApiService ??= OrderApiService();

    this._orderApiService = orderApiService;
  }

  Future<List<Order>> getOrders({@required int shopId}) async {
    List<dynamic> data = await this._orderApiService.getOrders(shopId: shopId);
    return data.map((model) => Order.fromJson(model)).toList();
  }
}
