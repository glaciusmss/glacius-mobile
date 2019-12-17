import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/layout/bloc/bloc.dart';
import 'package:glacius_mobile/views/order/bloc/bloc.dart';
import 'package:glacius_mobile/views/product/bloc/bloc.dart';

class PersistedBlocProvider extends StatelessWidget {
  final Widget child;

  PersistedBlocProvider({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<OrderBloc>(
          create: (context) {
            return OrderBloc(
              orderRepository: RepositoryProvider.of<OrderRepository>(context),
              shopBloc: BlocProvider.of<ShopBloc>(context),
            );
          },
        ),
        BlocProvider<ProductBloc>(
          create: (context) {
            return ProductBloc(
              productRepository: RepositoryProvider.of<ProductRepository>(
                context,
              ),
              shopBloc: BlocProvider.of<ShopBloc>(context),
            );
          },
        ),
        BlocProvider<LayoutBloc>(
          create: (context) {
            return LayoutBloc();
          },
        )
      ],
      child: child,
    );
  }
}
