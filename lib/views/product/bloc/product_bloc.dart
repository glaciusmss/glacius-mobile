import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import './bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  final ShopBloc shopBloc;

  ProductBloc({@required this.productRepository, @required this.shopBloc});

  @override
  ProductState get initialState => ProductInitial();

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProducts) {
      yield ProductLoading();
      List<Product> products = await productRepository.getProducts(
        shopId: shopBloc.getMyShop().id,
      );
      yield ProductLoaded(products: products.reversed.toList());
    }
  }
}
