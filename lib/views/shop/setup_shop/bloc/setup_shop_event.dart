import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class SetupShopEvent extends Equatable {
  const SetupShopEvent();

  @override
  List<Object> get props => [];
}

class CreateShop extends SetupShopEvent {
  final Shop shop;

  CreateShop({@required name, @required description})
      : shop = Shop(name: name, description: description);
}
