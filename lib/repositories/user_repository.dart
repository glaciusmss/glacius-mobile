import 'package:flutter/foundation.dart';
import 'package:glacius_mobile/models/models.dart';
import 'package:glacius_mobile/services/services.dart';

class UserRepository {
  UserApiService _userApiService;
  UserProfileApiService _userProfileApiService;
  SecureStoreService _secureStoreService;

  UserRepository({
    UserApiService userApiService,
    UserProfileApiService userProfileApiService,
    SecureStoreService secureStoreService,
  }) {
    userApiService ??= UserApiService();
    userProfileApiService ??= UserProfileApiService();
    secureStoreService ??= SecureStoreService();

    this._userApiService = userApiService;
    this._userProfileApiService = userProfileApiService;
    this._secureStoreService = secureStoreService;
  }

  Future<String> login({
    @required String email,
    @required String password,
  }) async {
    return await this._userApiService.login(email: email, password: password);
  }

  Future<void> logout() async {
    return this._userApiService.logout();
  }

  Future<User> loadUser() async {
    Map<String, dynamic> data = await this._userApiService.getMe();
    return User.fromJson(data);
  }

  Future<void> changePassword({
    @required String oldPassword,
    @required String password,
    @required String confirmPassword,
  }) async {
    return await this._userApiService.changePassword(
          oldPassword: oldPassword,
          password: password,
          confirmPassword: confirmPassword,
        );
  }

  Future<String> getToken() async {
    return await this._secureStoreService.getToken();
  }

  Future<bool> hasToken() async {
    return await this._secureStoreService.hasToken();
  }

  Future<void> persistToken({@required String token}) async {
    await this._secureStoreService.persistToken(token: token);
  }

  Future<void> deleteToken() async {
    await this._secureStoreService.deleteToken();
  }

  Future<UserProfile> loadUserProfile() async {
    Map data = await this._userProfileApiService.loadUserProfile();

    return UserProfile.fromJson(data);
  }

  Future<void> updateUserProfile({@required UserProfile userProfile}) async {
    return await this._userProfileApiService.updateUserProfile(
          userProfile: userProfile,
        );
  }
}
