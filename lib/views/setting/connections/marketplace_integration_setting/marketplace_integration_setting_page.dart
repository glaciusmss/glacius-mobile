import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/mixin/mixin.dart';
import 'package:glacius_mobile/views/setting/connections/widgets/widgets.dart';
import 'widgets/widgets.dart';
import 'bloc/bloc.dart';

class MarketplaceIntegrationSettingPage extends StatefulWidget {
  final MarketplaceIntegrationSettingBloc marketplaceIntegrationSettingBloc;
  final OAuthBloc oAuthBloc;

  const MarketplaceIntegrationSettingPage({
    @required this.marketplaceIntegrationSettingBloc,
    @required this.oAuthBloc,
  });

  @override
  _MarketplaceIntegrationSettingPageState createState() =>
      _MarketplaceIntegrationSettingPageState();
}

class _MarketplaceIntegrationSettingPageState
    extends State<MarketplaceIntegrationSettingPage> with UniversalLinkMixin {
  @override
  void initState() {
    super.initState();

    widget.marketplaceIntegrationSettingBloc.add(LoadMarketplaceIntegrations());
  }

  @override
  void onUniversalLinkCallback(Uri uri) {
    widget.marketplaceIntegrationSettingBloc.add(LoadMarketplaceIntegrations());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MarketplaceIntegrationSettingBloc,
        MarketplaceIntegrationSettingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: Text('Marketplace Connection')),
          body: Container(
            margin: EdgeInsets.all(10.0),
            child: (state is MarketplaceIntegrationSettingLoaded)
                ? Column(
                    children: <Widget>[
                      ListTile(
                        title: Text('Shopify'),
                        trailing: EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'shopify',
                          requiredFieldTitle: 'Shopify shop name',
                          requiredFieldOnConnect: 'shopify_shop',
                        ),
                      ),
                      ListTile(
                        title: Text('EasyStore'),
                        trailing: EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'easystore',
                          requiredFieldTitle: 'Easystore shop name',
                          requiredFieldOnConnect: 'easystore_shop',
                        ),
                      ),
                      ListTile(
                        title: Text('Shopee'),
                        trailing: EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'shopee',
                        ),
                      ),
                      ListTile(
                        title: Text('WooCommerce'),
                        trailing: EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'woocommerce',
                          requiredFieldTitle: 'WooCommerce store url',
                          requiredFieldOnConnect: 'woocommerce_store_url',
                        ),
                      ),
                    ],
                  )
                : ConnectionSkeletonLoader(count: 4),
          ),
        );
      },
    );
  }
}
