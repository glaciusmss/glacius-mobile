import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends OrderEvent {}

class StoreOrder extends OrderEvent {
  final Order order;
  final GlobalKey<AnimatedListState> animationKey;

  const StoreOrder({@required this.order, this.animationKey});

  @override
  List<Object> get props => [order, animationKey];
}

class MarkOrderAsRead extends OrderEvent {
  final int orderId;

  const MarkOrderAsRead({@required this.orderId});

  @override
  List<Object> get props => [orderId];
}
