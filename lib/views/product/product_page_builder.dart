import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glacius_mobile/views/product/product.dart';

import 'bloc/bloc.dart';

class ProductPageBuilder extends StatelessWidget {
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
    return child;
  }
}

class _InjectBlocListener extends StatelessWidget {
  final Widget child;

  _InjectBlocListener({this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

class _InjectBlocProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProductPage(
      productBloc: BlocProvider.of<ProductBloc>(context),
    );
  }
}
