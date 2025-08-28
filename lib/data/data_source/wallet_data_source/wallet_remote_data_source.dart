import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/settings_model/record_model.dart';
import 'package:new_sai/data/model/settings_model/redeems_record_model.dart';
import 'package:new_sai/data/model/wallet_model/unit_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/wallet_params/withdraw_params.dart';

abstract class WalletRemoteDataSource {
  Future<BaseMapModel<RecordPaginationModel>> getGiftRecords(int params);
  Future<BaseMapModel<RecordPaginationModel>> getBounceRecords(int params);
  Future<BaseMapModel<RedeemsRecordPaginationModel>> getMyRedeemsRecord(
      int params);
  Future<BaseMapModel> withdrawRequest(WithdrawParams params);
  Future<BaseMapModel<UnitModel>> getChargingUnits();
}

class WalletRemoteDataSourceImpl extends WalletRemoteDataSource {
  final AppServiceClient _appServiceClient;
  WalletRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<RecordPaginationModel>> getBounceRecords(
      int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.bounceRecord,
      RecordPaginationModel.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseMapModel<RecordPaginationModel>> getGiftRecords(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.giftRecord,
      RecordPaginationModel.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseMapModel<RedeemsRecordPaginationModel>> getMyRedeemsRecord(
      int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.redeemsRecord,
      RedeemsRecordPaginationModel.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseMapModel> withdrawRequest(WithdrawParams params) async {
    return await _appServiceClient.performPostRequest(
        EndPoint.redeemRequest, params.toJson(), (value) => null);
  }

  @override
  Future<BaseMapModel<UnitModel>> getChargingUnits() async {
    return await _appServiceClient.performGetRequest(
        EndPoint.shippingUnits, UnitModel.fromJson);
  }
}
