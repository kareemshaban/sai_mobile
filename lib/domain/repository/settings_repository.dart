import 'package:dartz/dartz.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/settings_params/change_email_phone_params.dart';
import 'package:new_sai/data/params/settings_params/change_password_params.dart';
import 'package:new_sai/data/params/settings_params/change_privacy_params.dart';
import 'package:new_sai/data/params/settings_params/get_settings_product_params.dart';
import 'package:new_sai/data/params/settings_params/report_params.dart';
import 'package:new_sai/domain/entity/settings_entity/premium_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/setting_market_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/settings_market_product_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/terms_privacy_entity.dart';

abstract class SettingsRepository {
  Future<Either<Failure, PremiumEntity>> getPremiumList();
  Future<Either<Failure, dynamic>> activatePremiuem(int params);
  Future<Either<Failure, dynamic>> renewPremiuem(int params);
  Future<Either<Failure, SettingMarketEntity>> getSettingMarket();
  Future<Either<Failure, List<SettingsMarketProductEntity>>>
      getSettingsMarketProduct(GetSettingsProductParams params);
  Future<Either<Failure, SettingsMarketProductEntity>> buySettingsMarketProduct(
      int params);
  Future<Either<Failure, bool>> seleceSettingsMarketProduct(int params);
  Future<Either<Failure, bool>> updateLanguagdde(String newLanguage);
  Future<Either<Failure, TermsPrivacyEntity>> getTermsAndPrivacy(int params);
  Future<Either<Failure, dynamic>> changePassword(ChangePasswordParams params);
  Future<Either<Failure, dynamic>> changePhone(ChangeEmailPhoneParams params);
  Future<Either<Failure, dynamic>> changeEmail(ChangeEmailPhoneParams params);
  Future<Either<Failure, dynamic>> sendCodeToEmail(
      ChangeEmailPhoneParams params);
  Future<Either<Failure, dynamic>> sendCodeToPhone(
      ChangeEmailPhoneParams params);
  Future<Either<Failure, dynamic>> report(ReportParams params);
  Future<Either<Failure, dynamic>> changePrivacy(ChangePrivacyParams params);
}
