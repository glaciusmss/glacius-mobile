import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';

abstract class MarketplaceIntegrationSettingState extends Equatable {
  const MarketplaceIntegrationSettingState();

  @override
  List<Object> get props => [];
}

class MarketplaceIntegrationSettingInitial
    extends MarketplaceIntegrationSettingState {}

class MarketplaceIntegrationSettingLoading
    extends MarketplaceIntegrationSettingState {}

class MarketplaceIntegrationSettingLoaded
    extends MarketplaceIntegrationSettingState {
  final List<Marketplace> integrations;

  MarketplaceIntegrationSettingLoaded({@required this.integrations});

  @override
  List<Object> get props => [integrations];
}
