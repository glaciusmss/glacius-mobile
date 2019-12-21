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
    return _BindBlocProvider(
      child: _InjectBlocListener(
        crudMode: crudMode,
        child: _InjectBlocProvider(
          crudMode: crudMode,
          routeArgs: routeArgs,
        ),
      ),
    );
  }
}

class _BindBlocProvider extends StatelessWidget {
  final Widget child;

  _BindBlocProvider({this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddUpdateProductBloc>(
      create: (context) {
        return AddUpdateProductBloc(
          productRepository: RepositoryProvider.of<ProductRepository>(context),
          shopBloc: BlocProvider.of<ShopBloc>(context),
        );
      },
      child: child,
    );
  }
}

class _InjectBlocListener extends StatelessWidget {
  final Widget child;
  final CrudMode crudMode;

  _InjectBlocListener({this.crudMode, this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddUpdateProductBloc, AddUpdateProductState>(
      listener: (context, state) {
        if (state is AddUpdateProductFailure) {
          print(state.error.toString());
        }

        if (state is AddUpdateProductSuccess) {
          Navigator.of(context).pop(
            crudMode == CrudMode.create ? 'Product Created' : 'Product Updated',
          );
        }

        if (state is AddUpdateProductSaving) {
          //hide keyboard when submit
          FocusScope.of(context).unfocus();
        }
      },
      child: child,
    );
  }
}

class _InjectBlocProvider extends StatelessWidget {
  final CrudMode crudMode;
  final Map<String, dynamic> routeArgs;

  _InjectBlocProvider({
    this.crudMode,
    this.routeArgs,
  });

  @override
  Widget build(BuildContext context) {
    return AddUpdateProductPage(
      addUpdateProductBloc: BlocProvider.of<AddUpdateProductBloc>(context),
      crudMode: crudMode,
      selectedProduct: routeArgs != null ? routeArgs['product'] : null,
    );
  }
}
