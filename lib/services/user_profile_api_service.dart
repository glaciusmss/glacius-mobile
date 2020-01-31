import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/utils/utils.dart';

class UserProfileApiService {
  Request _request;

  UserProfileApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<Map<String, dynamic>> loadUserProfile() async {
    Response res = await this._request.client.get(
          '/user_profile',
        );

    return res.data;
  }

  Future<void> updateUserProfile({@required UserProfile userProfile}) async {
    return await this._request.client.patch(
          '/user_profile/' + userProfile.id.toString(),
          data: userProfile.toJson(),
        );
  }
}
