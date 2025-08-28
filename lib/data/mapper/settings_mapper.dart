import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/settings_model/record_model.dart';
import 'package:new_sai/data/model/settings_model/redeems_record_model.dart';
import 'package:new_sai/data/model/settings_model/setting_market_model.dart';
import 'package:new_sai/data/model/settings_model/premium_model.dart';
import 'package:new_sai/data/model/settings_model/settings_market_product_model.dart';
import 'package:new_sai/data/model/settings_model/terms_privacy_model.dart';
import 'package:new_sai/data/model/settings_model/unique_id_model.dart';
import 'package:new_sai/domain/entity/settings_entity/record_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/redeems_record_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/setting_market_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/premium_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/settings_market_product_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/terms_privacy_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/unique_id_entity.dart';

extension PremiumMapper on PremiumModel? {
  PremiumEntity toDomain() {
    return PremiumEntity(
      type: this?.type ?? Constants.empty,
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      privileges: this?.privileges?.map((e) => e.toDomain()).toList() ?? [],
      categoryId: this?.categoryId ?? Constants.zero,
      duration: this?.duration ?? Constants.zero,
      isExpierd: this?.isExpierd ?? Constants.zero,
      totalCount: this?.totalCount ?? Constants.zero,
    );
  }
}

extension PrivilegesPremiumMapper on PrivilegesPremiumModel? {
  PrivilegesPremiumEntity toDomain() {
    return PrivilegesPremiumEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      description: this?.description ?? Constants.empty,
      icon: this?.icon ?? Constants.empty,
    );
  }
}

extension PremiumDataMapper on PremiumDataModel? {
  PremiumDataEntity toDomain() {
    return PremiumDataEntity(
      name: this?.name ?? Constants.empty,
      id: this?.id ?? Constants.zero,
      privileges: this?.privileges ?? [],
      activationPrice: this?.activationPrice ?? Constants.zero,
      badge: this?.badge ?? Constants.empty,
      count: this?.count ?? Constants.zero,
      renewalPrice: this?.renewalPrice ?? Constants.zero,
    );
  }
}

extension MarketMapper on SettingMarketModel? {
  SettingMarketEntity toDomain() {
    return SettingMarketEntity(
      goldValue: this?.goldValue ?? Constants.zero,
      room: this?.room?.map((e) => e.toDomain()).toList() ?? [],
      user: this?.user?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension UniqueIdMapper on UniqueIdModel? {
  UniqueIdEntity toDomain() {
    return UniqueIdEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      categoryIcon: this?.categoryIcon ?? Constants.empty,
      categoryDescription: this?.categoryDescription ?? Constants.empty,
      subcategories:
          this?.subcategories?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension UniqueSubCategoryMapper on UniqueSubCategoryModel? {
  UniqueSubCategoryEntity toDomain() {
    return UniqueSubCategoryEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      patterns: this?.patterns?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension PatternsMapper on PatternsModel? {
  PatternsEntity toDomain() {
    return PatternsEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
    );
  }
}

extension SettingsMarketProductMapper on SettingsMarketProductModel? {
  SettingsMarketProductEntity toDomain() {
    return SettingsMarketProductEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      image: this?.image ?? Constants.empty,
      category: this?.category ?? Constants.empty,
      isSelected: this?.isSelected ?? false,
      expirationDate: this?.expirationDate ?? Constants.empty,
      goldPrice: this?.goldPrice ?? Constants.zero,
      isBuy: this?.isBuy ?? false,
      productId: this?.productId ?? Constants.empty,
    );
  }
}

extension TermsPrivacyMapper on TermsPrivacyModel? {
  TermsPrivacyEntity toDomain() {
    return TermsPrivacyEntity(
      id: this?.id ?? Constants.zero,
      description: this?.description ?? Constants.empty,
      pageName: this?.pageName ?? Constants.empty,
    );
  }
}

extension RecordPaginationMapper on RecordPaginationModel? {
  RecordPaginationEntity toDomain() {
    return RecordPaginationEntity(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension RecordMapper on RecordModel? {
  RecordEntity toDomain() {
    return RecordEntity(
      id: this?.id ?? Constants.zero,
      toId: this?.toId ?? Constants.zero,
      user: this?.user ?? Constants.empty,
      goldValue: this?.goldValue ?? Constants.zero,
      date: this?.date ?? Constants.empty,
    );
  }
}

extension RedeemsRecordPaginationMapper on RedeemsRecordPaginationModel? {
  RedeemsRecordPaginationEntity toDomain() {
    return RedeemsRecordPaginationEntity(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension RedeemsRecordMapper on RedeemsRecordModel? {
  RedeemsRecordEntity toDomain() {
    return RedeemsRecordEntity(
      id: this?.id ?? Constants.zero,
      date: this?.date ?? Constants.empty,
      redeemTotal: this?.redeemTotal ?? Constants.zero,
    );
  }
}
