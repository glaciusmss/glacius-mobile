import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/shop/shop_bloc.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/marketplace_repository.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import './bloc.dart';

class MarketplaceIntegrationSettingBloc extends Bloc<
    MarketplaceIntegrationSettingEvent, MarketplaceIntegrationSettingState> {
  final MarketplaceRepository marketplaceRepository;
  final ShopBloc shopBloc;

  MarketplaceIntegrationSettingBloc({
    @required this.marketplaceRepository,
    @required this.shopBloc,
  });

  @override
  MarketplaceIntegrationSettingState get initialState =>
      MarketplaceIntegrationSettingInitial();

  @override
  Stream<MarketplaceIntegrationSettingState> mapEventToState(
    MarketplaceIntegrationSettingEvent event,
  ) async* {
    if (event is LoadMarketplaceIntegrations) {
      yield MarketplaceIntegrationSettingLoading();
      List<Marketplace> marketplaceIntegrations =
          await this.marketplaceRepository.getIntegrations(
                shopId: shopBloc.getMyShop().id,
              );
      yield MarketplaceIntegrationSettingLoaded(
        integrations: marketplaceIntegrations,
      );
    }
  }
}
