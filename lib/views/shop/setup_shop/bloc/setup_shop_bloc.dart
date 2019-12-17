import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import 'package:glacius_mobile/views/shop/setup_shop/bloc/bloc.dart';
import 'package:bloc/bloc.dart';

class SetupShopBloc extends Bloc<SetupShopEvent, SetupShopState> {
  ShopRepository shopRepository;

  SetupShopBloc({@required this.shopRepository});

  @override
  SetupShopState get initialState => SetupShopInitial();

  @override
  Stream<SetupShopState> mapEventToState(SetupShopEvent event) async* {
    if (event is CreateShop) {
      yield SetupShopSubmitting();
      try {
        Shop createdShop = await this.shopRepository.createShop(
              shop: event.shop,
            );
        yield SetupShopSuccess(shop: createdShop);
      } catch (error) {
        yield SetupShopFailure(error: error);
      }
    }
  }
}
