import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/wallet_data_source/wallet_remote_data_source.dart';
import 'package:new_sai/data/mapper/settings_mapper.dart';
import 'package:new_sai/data/mapper/wallet_mapper.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/wallet_params/withdraw_params.dart';
import 'package:new_sai/domain/entity/settings_entity/record_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/redeems_record_entity.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';
import 'package:new_sai/domain/repository/wallet_repository.dart';

class WalletRepositoryImp extends WalletRepository {
  final NetworkInfo _networkInfo;
  final WalletRemoteDataSource _remoteDataSource;
  WalletRepositoryImp(this._networkInfo, this._remoteDataSource);
  @override
  Future<Either<Failure, RecordPaginationEntity>> getBounceRecords(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getBounceRecords(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ''));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, RecordPaginationEntity>> getGiftRecords(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getGiftRecords(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ''));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, RedeemsRecordPaginationEntity>> getMyRedeemsRecord(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getMyRedeemsRecord(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ''));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, BaseMapModel>> withdrawRequest(
      WithdrawParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.withdrawRequest(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response);
        } else {
          return Left(Failure(code: 0, message: response.message ?? ''));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, UnitEntity>> getChargingUnits() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getChargingUnits();
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ''));
        }
      } catch (e, stackTrance) {
        log(e.toString());
        log(stackTrance.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
