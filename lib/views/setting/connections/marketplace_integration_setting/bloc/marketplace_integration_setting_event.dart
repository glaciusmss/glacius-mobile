import 'package:equatable/equatable.dart';

abstract class MarketplaceIntegrationSettingEvent extends Equatable {
  const MarketplaceIntegrationSettingEvent();

  @override
  List<Object> get props => [];
}

class LoadMarketplaceIntegrations extends MarketplaceIntegrationSettingEvent {}
