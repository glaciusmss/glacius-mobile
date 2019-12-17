import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'bloc.dart';

class AddUpdateProductBloc
    extends Bloc<AddUpdateProductEvent, AddUpdateProductState> {
  final ProductRepository productRepository;
  final ShopBloc shopBloc;

  AddUpdateProductBloc({
    @required this.productRepository,
    @required this.shopBloc,
  });

  @override
  AddUpdateProductState get initialState => AddUpdateProductInitial();

  @override
  Stream<AddUpdateProductState> mapEventToState(
    AddUpdateProductEvent event,
  ) async* {
    if (event is CreateProduct) {
      yield AddUpdateProductSaving();
      try {
        await this.productRepository.createProduct(
              product: event.product,
              shopId: shopBloc.getMyShop().id,
            );
        yield AddUpdateProductSuccess();
      } catch (error) {
        yield AddUpdateProductFailure(error: error);
      }
    }

    if (event is UpdateProduct) {
      yield AddUpdateProductSaving();
      try {
        await this.productRepository.updateProduct(
              product: event.product,
              shopId: shopBloc.getMyShop().id,
            );
        yield AddUpdateProductSuccess();
      } catch (error) {
        yield AddUpdateProductFailure(error: error);
      }
    }
  }
}
