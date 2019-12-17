import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class SetupShopState extends Equatable {
  const SetupShopState();

  @override
  List<Object> get props => [];
}

class SetupShopInitial extends SetupShopState {}

class SetupShopSubmitting extends SetupShopState {}

class SetupShopSuccess extends SetupShopState {
  final Shop shop;

  SetupShopSuccess({@required this.shop});

  @override
  List<Object> get props => [shop];
}

class SetupShopFailure extends SetupShopState {
  final Exception error;

  const SetupShopFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
