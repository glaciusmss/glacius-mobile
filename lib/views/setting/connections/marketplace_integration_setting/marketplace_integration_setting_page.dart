import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/mixin/mixin.dart';
import 'package:shimmer/shimmer.dart';
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
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Shopify'),
                  trailing: (state is MarketplaceIntegrationSettingLoaded)
                      ? EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'shopify',
                          requiredFieldTitle: 'Shopify shop name',
                          requiredFieldOnConnect: 'shopify_shop',
                        )
                      : _skeletonButton(),
                ),
                ListTile(
                  title: Text('EasyStore'),
                  trailing: (state is MarketplaceIntegrationSettingLoaded)
                      ? EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'easystore',
                          requiredFieldTitle: 'Easystore shop name',
                          requiredFieldOnConnect: 'easystore_shop',
                        )
                      : _skeletonButton(),
                ),
                ListTile(
                  title: Text('Shopee'),
                  trailing: (state is MarketplaceIntegrationSettingLoaded)
                      ? EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'shopee',
                        )
                      : _skeletonButton(),
                ),
                ListTile(
                  title: Text('WooCommerce'),
                  trailing: (state is MarketplaceIntegrationSettingLoaded)
                      ? EnableDisableButton(
                          oAuthBloc: widget.oAuthBloc,
                          integrations: state.integrations,
                          marketplace: 'woocommerce',
                          requiredFieldTitle: 'WooCommerce store url',
                          requiredFieldOnConnect: 'woocommerce_store_url',
                        )
                      : _skeletonButton(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _skeletonButton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
      child: Container(
        height: 35.0,
        width: 90.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          color: Colors.white,
        ),
      ),
    );
  }
}
