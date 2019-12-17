import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/utils/utils.dart';

class UserApiService {
  Request _request;

  UserApiService({Request request}) {
    this._request = request ??= Request();
  }

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    Response res = await this._request.client.post(
      '/user/login',
      data: {'email': email, 'password': password},
    );

    return res.data['token'];
  }

  Future<void> logout() async {
    return this._request.client.post('/user/logout');
  }

  Future<Map<String, dynamic>> getMe() async {
    Response res = await this._request.client.get('/user/me');
    return res.data;
  }

  Future<void> changePassword({
    @required String oldPassword,
    @required String password,
    @required String confirmPassword,
  }) async {
    return await this._request.client.patch('/user/password', data: {
      'old_password': oldPassword,
      'password': password,
      'confirm_password': confirmPassword,
    });
  }
}
