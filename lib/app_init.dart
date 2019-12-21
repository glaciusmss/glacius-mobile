import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/views/login/login.dart';
import 'package:glacius_mobile/views/shop/setup_shop/setup_shop.dart';
import 'package:glacius_mobile/views/splash_screen.dart';
import 'package:glacius_mobile/widgets/spinner.dart';

class AppInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is MyShopLoaded && state.myShop.isNotEmpty) {
          //setup echo
          BlocProvider.of<WebsocketBloc>(context).add(SetupEcho());

          //setup firebase
          BlocProvider.of<NotificationBloc>(context).add(
            SetupFirebaseMessaging(),
          );

          // main page
          SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          Navigator.pushReplacementNamed(context, '/main');
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthUnauthenticated) {
            SystemChrome.setEnabledSystemUIOverlays(
              SystemUiOverlay.values,
            );
            return LoginPageBuilder();
          }

          if (state is AuthAuthenticated) {
            BlocProvider.of<ShopBloc>(context).add(LoadMyShop());
            return BlocBuilder<ShopBloc, ShopState>(
              builder: (context, state) {
                if (state is MyShopLoaded && state.myShop.isEmpty) {
                  SystemChrome.setEnabledSystemUIOverlays(
                    SystemUiOverlay.values,
                  );
                  return SetupShopPageBuilder();
                }

                return Spinner.withScaffold(context);
              },
            );
          }

          if (state is AuthLoading) {
            return Spinner.withScaffold(context);
          }

          SystemChrome.setEnabledSystemUIOverlays([]);
          return SplashScreen();
        },
      ),
    );
  }
}
