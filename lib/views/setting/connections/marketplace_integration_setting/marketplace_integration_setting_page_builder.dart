import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/shop/shop_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/setting/connections/marketplace_integration_setting/bloc/bloc.dart';
import 'package:glacius_mobile/views/setting/connections/marketplace_integration_setting/marketplace_integration_setting_page.dart';

class MarketplaceIntegrationSettingPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<MarketplaceIntegrationSettingBloc>(
          create: (context) {
            return MarketplaceIntegrationSettingBloc(
              marketplaceRepository:
                  RepositoryProvider.of<MarketplaceRepository>(context),
              shopBloc: BlocProvider.of<ShopBloc>(context),
            );
          },
        ),
        BlocProvider<OAuthBloc>(
          create: (context) {
            return OAuthBloc(
              oAuthRepository: RepositoryProvider.of<OAuthRepository>(context),
              shopBloc: BlocProvider.of<ShopBloc>(context),
            );
          },
        )
      ],
      child: MarketplaceIntegrationSettingPage(),
    );
  }
}
