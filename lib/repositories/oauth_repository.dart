import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/services/services.dart';

class OAuthRepository {
  OAuthApiService _oAuthApiService;

  OAuthRepository({OAuthApiService oAuthApiService}) {
    oAuthApiService ??= OAuthApiService();

    this._oAuthApiService = oAuthApiService;
  }

  Future<String> connectOAuth({
    @required String marketplace,
    @required int shopId,
    Map data,
  }) async {
    Map resData = await this._oAuthApiService.connectOAuth(
          marketplace: marketplace,
          shopId: shopId,
          data: data,
        );

    return resData['url'];
  }

  Future<dynamic> deleteOAuth({
    @required String marketplace,
    @required int shopId,
  }) async {
    return await this._oAuthApiService.deleteOAuth(
          marketplace: marketplace,
          shopId: shopId,
        );
  }
}
