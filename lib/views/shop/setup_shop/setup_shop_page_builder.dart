import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/shop/shop_bloc.dart';
import 'package:glacius_mobile/bloc/shop/shop_event.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/shop/shop.dart';
import 'bloc/bloc.dart';

class SetupShopPageBuilder extends StatelessWidget {
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
    return BlocProvider<SetupShopBloc>(
      create: (context) {
        return SetupShopBloc(
          shopRepository: RepositoryProvider.of<ShopRepository>(context),
        );
      },
      child: child,
    );
  }
}

class _InjectBlocListener extends StatelessWidget {
  final Widget child;

  _InjectBlocListener({this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SetupShopBloc, SetupShopState>(
      listener: (context, state) {
        if (state is SetupShopSuccess) {
          BlocProvider.of<ShopBloc>(context).add(
            AddToMyShopAfterCreated(shop: state.shop),
          );
        }
      },
      child: child,
    );
  }
}

class _InjectBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SetupShopPage(
      setupShopBloc: BlocProvider.of<SetupShopBloc>(context),
    );
  }
}
