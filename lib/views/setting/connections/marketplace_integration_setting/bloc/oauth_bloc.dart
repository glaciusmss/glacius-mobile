import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/bloc/shop/shop_bloc.dart';
import 'package:glacius_mobile/repositories/repositories.dart';
import './bloc.dart';

class OAuthBloc extends Bloc<OAuthEvent, OAuthState> {
  final OAuthRepository oAuthRepository;
  final ShopBloc shopBloc;

  OAuthBloc({
    @required this.oAuthRepository,
    @required this.shopBloc,
  });

  @override
  OAuthState get initialState => OAuthInitial();

  @override
  Stream<OAuthState> mapEventToState(OAuthEvent event) async* {
    if (event is DisconnectOAuth) {
      try {
        yield OAuthUpdating(marketplace: event.marketplace);
        Response response = await this.oAuthRepository.deleteOAuth(
              marketplace: event.marketplace,
              shopId: this.shopBloc.getMyShop().id,
            );
        if (event.marketplace == 'shopee') {
          yield OAuthGetConnectUrlSuccess(url: response.data['url']);
        } else {
          yield OAuthDisableSuccess();
        }
      } catch (error) {
        yield OAuthDisableFailure(error: error);
      }
    }

    if (event is ConnectOAuth) {
      yield OAuthGetConnectUrlLoading(marketplace: event.marketplace);
      String url = await this.oAuthRepository.connectOAuth(
            marketplace: event.marketplace,
            shopId: this.shopBloc.getMyShop().id,
            data: event.data,
          );
      yield OAuthGetConnectUrlSuccess(url: url);
    }
  }
}
