import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/shop/shop_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/setting/connections/marketplace_integration_setting/bloc/bloc.dart';
import 'package:glacius_mobile/views/setting/connections/marketplace_integration_setting/marketplace_integration_setting_page.dart';

class MarketplaceIntegrationSettingPageBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _BindBlocProvider(
      child: _InjectBlocListener(
        child: _InjectBlocProvider(),
      ),
    );
  }
}

class _BindBlocProvider extends StatelessWidget {
  final Widget child;

  _BindBlocProvider({this.child});

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
      child: child,
    );
  }
}

class _InjectBlocListener extends StatelessWidget {
  final Widget child;

  _InjectBlocListener({this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<OAuthBloc, OAuthState>(
      listener: (context, state) {
        if (state is OAuthDisableSuccess) {
          BlocProvider.of<MarketplaceIntegrationSettingBloc>(context)
              .add(LoadMarketplaceIntegrations());
        }

        if (state is OAuthGetConnectUrlSuccess) {
          //start in browser
          OAuthHelper(
            browser: OAuthBrowser(onClosedCallback: () {
              BlocProvider.of<MarketplaceIntegrationSettingBloc>(context)
                  .add(LoadMarketplaceIntegrations());
            }),
          ).connect(state.url);
        }
      },
      child: child,
    );
  }
}

class _InjectBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MarketplaceIntegrationSettingPage(
      oAuthBloc: BlocProvider.of<OAuthBloc>(context),
      marketplaceIntegrationSettingBloc:
          BlocProvider.of<MarketplaceIntegrationSettingBloc>(context),
    );
  }
}
