import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/bloc.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/repositories/repositories.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopRepository shopRepository;

  ShopBloc({@required this.shopRepository});

  @override
  ShopState get initialState => ShopInitial();

  @override
  Stream<ShopState> mapEventToState(ShopEvent event) async* {
    if (event is LoadMyShop) {
      yield MyShopLoading();
      List<Shop> myShop = await this.shopRepository.getMyShops();
      yield MyShopLoaded(myShop: myShop);
    }

    if (event is ResetShopBloc) {
      yield ShopInitial();
    }

    if (event is AddToMyShopAfterCreated) {
      yield MyShopLoaded(myShop: [event.shop]);
    }
  }

  Shop getMyShop() {
    if (state is MyShopLoaded) {
      return (state as MyShopLoaded).myShop.first;
    }

    return null;
  }
}
