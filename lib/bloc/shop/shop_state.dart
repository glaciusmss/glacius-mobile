import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class ShopState extends Equatable {
  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class MyShopLoading extends ShopState {}

class MyShopLoaded extends ShopState {
  final List<Shop> myShop;

  MyShopLoaded({@required this.myShop});

  @override
  List<Object> get props => [myShop];
}
