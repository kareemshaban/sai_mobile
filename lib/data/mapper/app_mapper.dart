import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/auth_mapper.dart';
import 'package:new_sai/data/mapper/reels_mapper.dart';
import 'package:new_sai/data/model/app_model/app_info_model.dart';
import 'package:new_sai/data/model/app_model/app_search_model.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/model/app_model/images_model.dart';
import 'package:new_sai/data/model/app_model/name_model.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/domain/entity/app_entity/app_info_entity.dart';
import 'package:new_sai/domain/entity/app_entity/app_search_entity.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/entity/app_entity/images_entity.dart';
import 'package:new_sai/domain/entity/app_entity/name_entity.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';

extension NameMapper on NameModel? {
  NameEntity toDomain() {
    return NameEntity(
      en: this?.en ?? Constants.empty,
      ar: this?.ar ?? Constants.empty,
    );
  }
}

extension CountryMapper on CountryModel? {
  CountryEntity toDomain() {
    return CountryEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      flag: this?.flag ?? Constants.empty,
      isFamous: this?.isFamous ?? Constants.zero,
    );
  }
}

extension PaginationMapper on PaginationModel? {
  PaginationEntity toDomain() {
    return PaginationEntity(
      path: this?.path ?? Constants.empty,
      total: this?.total ?? Constants.zero,
      currentPage: this?.currentPage ?? Constants.zero,
      lastPage: this?.lastPage ?? Constants.zero,
      nextPageUrl: this?.nextPageUrl ?? Constants.empty,
      perPage: this?.perPage ?? Constants.zero,
      prevPageUrl: this?.prevPageUrl ?? Constants.empty,
    );
  }
}

extension ImagesMapper on ImagesModel? {
  ImagesEntity toDomain() {
    return ImagesEntity(
      id: this?.id ?? Constants.zero,
      imagePath: this?.imagePath ?? Constants.empty,
    );
  }
}

extension AppInfoMapper on AppInfoModel? {
  AppInfoEntity toDomain() {
    return AppInfoEntity(
      activateRedeemGolds: this?.activateRedeemGolds ?? Constants.zero,
      androidUrl: this?.androidUrl ?? Constants.empty,
      androidVersion: this?.androidVersion ?? Constants.empty,
      iosUrl: this?.iosUrl ?? Constants.empty,
      iosVersion: this?.iosVersion ?? Constants.empty,
      vip: this?.vip ?? Constants.empty,
    );
  }
}

extension AppSearchMapper on AppSearchModel? {
  AppSearchEntity toDomain() {
    return AppSearchEntity(
      videos: this?.videos?.map((e) => e.toDomain()).toList() ?? [],
      hashTags: this?.hashTags ?? [],
      users: this?.users?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}
