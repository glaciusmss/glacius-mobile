import 'package:flutter/material.dart';
import 'package:glacius_mobile/app_init.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/layout/layout.dart';
import 'package:glacius_mobile/views/product/add_update_product/add_update_product.dart';
import 'package:glacius_mobile/views/setting/about/about.dart';
import 'package:glacius_mobile/views/setting/account/account_profile/account_profile.dart';
import 'package:glacius_mobile/views/setting/account/change_password/change_password_page_builder.dart';
import 'package:glacius_mobile/views/setting/connections/marketplace_integration_setting/marketplace_integration_setting.dart';
import 'package:glacius_mobile/views/setting/connections/notification_integration_setting/notification_integration_setting.dart';
import 'package:glacius_mobile/views/setting/setting.dart';

class Routes {
  static PageRouteBuilder generateRoutes(RouteSettings settings) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return Routes.configureRoutes(
          settings.arguments,
        )[settings.name](context);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (settings.name == '/' || settings.name == '/main') {
          return FadeTransition(opacity: animation, child: child);
        }

        return SlideTransition(
          transformHitTests: false,
          position: Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset.zero,
              end: const Offset(-1.0, 0.0),
            ).animate(secondaryAnimation),
            child: child,
          ),
        );
      },
      transitionDuration: settings.name == '/' || settings.name == '/main'
          ? Duration(milliseconds: 500)
          : Duration(milliseconds: 200),
    );
  }

  static Map<String, WidgetBuilder> configureRoutes(Object args) {
    return {
      '/': (context) => AppInit(),
      '/main': (context) => LayoutPageBuilder(),
      '/product/add': (context) => AddUpdateProductPageBuilder(
            crudMode: CrudMode.create,
          ),
      '/product/update': (context) => AddUpdateProductPageBuilder(
            crudMode: CrudMode.update,
            routeArgs: args,
          ),
      '/settings': (context) => SettingPage(routeArgs: args),
      '/settings/account/account_profile': (context) =>
          AccountProfilePageBuilder(),
      '/settings/account/change_password': (context) =>
          ChangePasswordPageBuilder(),
      '/settings/connections/marketplaces': (context) =>
          MarketplaceIntegrationSettingPageBuilder(),
      '/settings/connections/notifications': (context) =>
          NotificationIntegrationSettingPageBuilder(),
      '/settings/about': (context) => AboutPage(),
    };
  }
}
