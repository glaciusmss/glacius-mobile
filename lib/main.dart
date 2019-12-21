import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:glacius_mobile/bloc/auth/auth.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/bloc/universal_link/universal_link.dart';
import 'package:glacius_mobile/config/config.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/utils/utils.dart';

import 'bloc/shop/shop_bloc.dart';

Future main() async {
  await DotEnv().load('.env');
  await Application.loadPackageInfo();
  BlocSupervisor.delegate = LogBlocDelegate();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepository>(
          create: (context) => UserRepository(),
        ),
        RepositoryProvider<ShopRepository>(
          create: (context) => ShopRepository(),
        ),
        RepositoryProvider<OrderRepository>(
          create: (context) => OrderRepository(),
        ),
        RepositoryProvider<MarketplaceRepository>(
          create: (context) => MarketplaceRepository(),
        ),
        RepositoryProvider<OAuthRepository>(
          create: (context) => OAuthRepository(),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => NotificationRepository(),
        ),
        RepositoryProvider<ProductRepository>(
          create: (context) => ProductRepository(),
        ),
        RepositoryProvider<ImageRepository>(
          create: (context) => ImageRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: <BlocProvider>[
          BlocProvider<UniversalLinkBloc>(
            create: (context) {
              return UniversalLinkBloc();
            },
          ),
          BlocProvider<ShopBloc>(
            create: (context) {
              return ShopBloc(
                shopRepository: RepositoryProvider.of<ShopRepository>(context),
              );
            },
          ),
          BlocProvider<NotificationBloc>(
            create: (context) {
              return NotificationBloc(
                shopBloc: BlocProvider.of<ShopBloc>(context),
              );
            },
          ),
          BlocProvider<AuthBloc>(
            create: (context) {
              return AuthBloc(
                shopBloc: BlocProvider.of<ShopBloc>(context),
                notificationBloc: BlocProvider.of<NotificationBloc>(context),
                userRepository: RepositoryProvider.of<UserRepository>(context),
              )..add(AppStarted());
            },
          ),
          BlocProvider<WebsocketBloc>(
            create: (context) {
              return WebsocketBloc(
                authBloc: BlocProvider.of<AuthBloc>(context),
                shopBloc: BlocProvider.of<ShopBloc>(context),
              );
            },
          )
        ],
        child: App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Glacius',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF0175c2),
        accentColor: Color(0xFF13B9FD),
        errorColor: Color(0xfff86c6b),
        indicatorColor: Color(0xff20a8d8),
        backgroundColor: Colors.white,
      ),
      initialRoute: '/',
      onGenerateRoute: Routes.generateRoutes,
    );
  }
}
