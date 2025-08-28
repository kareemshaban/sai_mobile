import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/wallet_params/withdraw_params.dart';
import 'package:new_sai/domain/entity/settings_entity/record_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/redeems_record_entity.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';

abstract class WalletRepository {
  Future<Either<Failure, RecordPaginationEntity>> getGiftRecords(int params);
  Future<Either<Failure, RecordPaginationEntity>> getBounceRecords(int params);
  Future<Either<Failure, RedeemsRecordPaginationEntity>> getMyRedeemsRecord(
      int params);
  Future<Either<Failure, BaseMapModel>> withdrawRequest(WithdrawParams params);
  Future<Either<Failure, UnitEntity>> getChargingUnits();
}
