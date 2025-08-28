import 'dart:developer';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/model/auth_model/user_model.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/use_case/room_use_case/get_gift_list_use_case.dart';
import 'package:new_sai/domain/use_case/store_use_case/add_remove_favorite_use_case.dart';

import 'di/basic_di.dart';

class AppController extends GetxController {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final AddRemoveFavoriteUseCase _addRemoveFavoriteUseCase =
      instance<AddRemoveFavoriteUseCase>();
  final GetGiftListUseCase _getGiftListUseCase = instance<GetGiftListUseCase>();
  bool activeGold = false;
  bool vipActive = false;

  final Rx<UserEntity> _user = UserModel().toDomain().obs;

  UserEntity get user => _user.value;

  set user(UserEntity value) => _user.value = value;

  saveUser(UserEntity value) async {
    user = value;

    _user.refresh();
    await _appPreferences.setUser(value);
  }

  getUser() {
    user = _appPreferences.getUser();
    _user.refresh();
  }

  bool isGuest() => _appPreferences.getUserToken().isEmpty;

  Future<bool> addRemoveFavorite(int params) async =>
      (await _addRemoveFavoriteUseCase.execute(params)).fold(
        (l) {
          return false;
        },
        (r) {
          return true;
        },
      );

  updateUserGold(num value) {
    user.goldValue = value;
    _user.refresh();
    saveUser(user);
  }

  cacheAllGift() async {
    (await _getGiftListUseCase.execute("")).fold(
      (l) {},
      (r) async {
        for (var element in r) {
          try {
            final cache =
                await DefaultCacheManager().getFileFromCache(element.giftFile);
            if (cache == null) {
              final file =
                  await DefaultCacheManager().downloadFile(element.giftFile);
              await DefaultCacheManager()
                  .putFile(file.file.path, await file.file.readAsBytes());
            }
          } catch (e) {
            log(e.toString());
          }
        }
      },
    );
  }

  goldReddemeActive(bool value) {
    activeGold = value;
  }

  activeVip(bool value) {
    vipActive = value;
  }

  bool isGoldReddemeActive() {
    return activeGold;
  }

  bool isVipActive() {
    return vipActive;
  }

  @override
  void onInit() {
    getUser();
    cacheAllGift();
    super.onInit();
  }
}
