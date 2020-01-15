import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {}

class RefreshOrders extends OrderEvent {
  final RefreshController refreshController;

  const RefreshOrders({@required this.refreshController});

  @override
  List<Object> get props => [refreshController];
}

class LoadMoreOrders extends OrderEvent {
  final RefreshController refreshController;

  const LoadMoreOrders({@required this.refreshController});

  @override
  List<Object> get props => [refreshController];
}

class StoreOrder extends OrderEvent {
  final Order order;

  const StoreOrder({@required this.order});

  @override
  List<Object> get props => [order];
}

class MarkOrderAsRead extends OrderEvent {
  final int orderId;

  const MarkOrderAsRead({@required this.orderId});

  @override
  List<Object> get props => [orderId];
}
