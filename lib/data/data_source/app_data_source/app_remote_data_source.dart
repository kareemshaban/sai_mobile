import 'package:new_sai/data/model/app_model/app_info_model.dart';
import 'package:new_sai/data/model/app_model/app_search_model.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/app_params/app_search_params.dart';

abstract class AppRemoteDataSource {
  Future<BaseListModel<CountryModel>> getCountryList();
  Future<BaseMapModel<AppInfoModel>> getAppInfo();
  Future<BaseMapModel<AppSearchModel>> getAppSearch(AppSearchParams params);
}

class AppRemoteDataSourceImpl extends AppRemoteDataSource {
  final AppServiceClient _appServiceClient;

  AppRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseListModel<CountryModel>> getCountryList() async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.countryList,
      CountryModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<AppInfoModel>> getAppInfo() async {
    return await _appServiceClient.performGetRequest(
      EndPoint.appInfo,
      AppInfoModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel<AppSearchModel>> getAppSearch(
      AppSearchParams params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.appSearch(params),
      AppSearchModel.fromJson,
    );
  }
}
