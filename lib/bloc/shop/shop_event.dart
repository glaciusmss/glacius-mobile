import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class LoadMyShop extends ShopEvent {}

class ResetShopBloc extends ShopEvent {}

class AddToMyShopAfterCreated extends ShopEvent {
  final Shop shop;

  const AddToMyShopAfterCreated({@required this.shop});

  @override
  List<Object> get props => [shop];
}
