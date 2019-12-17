import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<Order> orders;
  final List<int> updatedOrderIds;

  OrdersLoaded({@required this.orders, this.updatedOrderIds = const []});

  @override
  List<Object> get props => [orders, updatedOrderIds];
}
