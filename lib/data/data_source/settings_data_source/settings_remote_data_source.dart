import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/settings_model/premium_model.dart';
import 'package:new_sai/data/model/settings_model/setting_market_model.dart';
import 'package:new_sai/data/model/settings_model/settings_market_product_model.dart';
import 'package:new_sai/data/model/settings_model/terms_privacy_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/settings_params/change_email_phone_params.dart';
import 'package:new_sai/data/params/settings_params/change_password_params.dart';
import 'package:new_sai/data/params/settings_params/change_privacy_params.dart';
import 'package:new_sai/data/params/settings_params/get_settings_product_params.dart';
import 'package:new_sai/data/params/settings_params/report_params.dart';

abstract class SettingsRemoteDataSource {
  Future<BaseMapModel<PremiumModel>> getPremiumList();
  Future<BaseMapModel> activatePremium(int params);
  Future<BaseMapModel> renewPremium(int params);
  Future<BaseMapModel<SettingMarketModel>> getSettingMarket();
  Future<BaseListModel<SettingsMarketProductModel>> getSettingsMarketProduct(
      GetSettingsProductParams params);
  Future<BaseMapModel<SettingsMarketProductModel>> buySettingsMarketProduct(
      int params);
  Future<BaseMapModel> seleceSettingsMarketProduct(int params);
  Future<BaseMapModel> updateLanguage(String params);
  Future<BaseMapModel<TermsPrivacyModel>> getTermsAndPrivacy(int params);
  Future<BaseMapModel> changePassword(ChangePasswordParams params);
  Future<BaseMapModel> changePhone(ChangeEmailPhoneParams params);
  Future<BaseMapModel> changeEmail(ChangeEmailPhoneParams params);
  Future<BaseMapModel> sendCodeToPhone(ChangeEmailPhoneParams params);
  Future<BaseMapModel> sendCodeToEmail(ChangeEmailPhoneParams params);

  Future<BaseMapModel> report(ReportParams params);
  Future<BaseMapModel> changePrivacy(ChangePrivacyParams params);
}

class SettingsRemoteDataSourceImpl extends SettingsRemoteDataSource {
  final AppServiceClient _appServiceClient;
  SettingsRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<PremiumModel>> getPremiumList() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.premiumList,
      PremiumModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> activatePremium(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.activatePremium(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> renewPremium(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.renewPremium(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<SettingMarketModel>> getSettingMarket() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.settingMarket,
      SettingMarketModel.fromJson,
    );
  }

  @override
  Future<BaseListModel<SettingsMarketProductModel>> getSettingsMarketProduct(
      GetSettingsProductParams params) async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.settingMarketProduct(params.catID!),
      SettingsMarketProductModel.fromJson,
      params: params.toJson(),
    );
  }

  @override
  Future<BaseMapModel<SettingsMarketProductModel>> buySettingsMarketProduct(
      int params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.buySettings,
      {
        'product_id': params,
      },
      SettingsMarketProductModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> seleceSettingsMarketProduct(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.selectSettingProduct(params),
      (value) => null,
    );
  }
  @override
  Future<BaseMapModel> updateLanguage(String params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.updateLang(params),
      // {},
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<TermsPrivacyModel>> getTermsAndPrivacy(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.termsPrivacy(params),
      TermsPrivacyModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> changePassword(ChangePasswordParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.changePassword,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> changeEmail(ChangeEmailPhoneParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.changeEmail,
      params.toJson(),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel> changePhone(ChangeEmailPhoneParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.changePhone,
      params.toJson(),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel> sendCodeToEmail(ChangeEmailPhoneParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.sendCodeToEmail,
      params.toJson(),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel> sendCodeToPhone(ChangeEmailPhoneParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.sendCodeToPhone,
      params.toJson(),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel> changePrivacy(ChangePrivacyParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.changePrivacy,
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> report(ReportParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.report,
      params.toJson(),
      (value) => null,
    );
  }
}
