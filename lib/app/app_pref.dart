import 'dart:convert';

import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/data/model/store_model/address_model.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/presentation/pages/address_pages/address/getx/address_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_controller.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:shared_preferences/shared_preferences.dart';

String langKey = 'langKey';
String userTokenKey = 'userTokenKey';
String userKey = 'userKey';
String notificationKey = 'notificationKey';

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  String getAppLanguage() {
    String? language = _sharedPreferences.getString(langKey);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.arabic.getValue();
    }
  }

  Future<void> setAppLanguage(String language) async {
    _sharedPreferences.setString(langKey, language);
  }

  String getUserToken() {
    return _sharedPreferences.getString(userTokenKey) ?? "";
  }

  Future<void> setUserToken(String value) async {
    await _sharedPreferences.setString(userTokenKey, value);
  }

  UserEntity  getUser() {
    if (_sharedPreferences.getString(userKey) != null) {
      return UserEntity.fromJson(
          jsonDecode(_sharedPreferences.getString(userKey) ?? "{}"));
    }
    return UserModel().toDomain();
  }

  Future<void> setUser(UserEntity value) async {
    await _sharedPreferences.setString(userKey, jsonEncode(value.toJson()));
  }

  Future<void> setNotificationID(String id) async {
    await _sharedPreferences.setString(notificationKey, id);
  }

  String getNotificationID() {
    return _sharedPreferences.getString(notificationKey) ?? "";
  }

  Future<void> logout() async {
    Get.find<AddressController>().addresses.clear();
    Get.find<AddressController>().selectedAddress = AddressModel().toDomain();
    Get.find<CartController>().deleteCard();
    Get.find<AppController>().user = UserModel().toDomain();
    await _sharedPreferences.remove(userTokenKey);
    await _sharedPreferences.remove(userKey);
  }
}
