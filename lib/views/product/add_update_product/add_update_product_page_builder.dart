import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/utils/utils.dart';
import 'package:glacius_mobile/views/product/add_update_product/add_update_product.dart';
import 'package:glacius_mobile/views/product/add_update_product/bloc/bloc.dart';

class AddUpdateProductPageBuilder extends StatelessWidget {
  final CrudMode crudMode;
  final Map<String, dynamic> routeArgs;

  AddUpdateProductPageBuilder({
    @required this.crudMode,
    this.routeArgs,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddUpdateProductBloc>(
      create: (context) {
        return AddUpdateProductBloc(
          productRepository: RepositoryProvider.of<ProductRepository>(context),
          shopBloc: BlocProvider.of<ShopBloc>(context)
        );
      },
      child: AddUpdateProductPage(
        crudMode: crudMode,
        selectedProduct: routeArgs != null ? routeArgs['product'] : null,
      ),
    );
  }
}
