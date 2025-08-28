import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/app_data_source/app_remote_data_source.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/app_params/app_search_params.dart';
import 'package:new_sai/domain/entity/app_entity/app_info_entity.dart';
import 'package:new_sai/domain/entity/app_entity/app_search_entity.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/repository/app_repository.dart';

class AppRepositoryImpl extends AppRepository {
  final NetworkInfo _networkInfo;
  final AppRemoteDataSource _appRemoteDataSource;

  AppRepositoryImpl(this._appRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<CountryEntity>>> getCountryList() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _appRemoteDataSource.getCountryList();
        if (response.success == ApiInternalStatus.success) {
          final data = response.data?.map((e) => e.toDomain()).toList() ?? [];
          return Right(data);
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
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
  Future<Either<Failure, AppInfoEntity>> getAppInfo() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _appRemoteDataSource.getAppInfo();
        if (response.success == ApiInternalStatus.success) {
          final data = response.data.toDomain();
          return Right(data);
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
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
  Future<Either<Failure, AppSearchEntity>> getAppSearch(
      AppSearchParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _appRemoteDataSource.getAppSearch(params);
        if (response.success == ApiInternalStatus.success) {
          final data = response.data.toDomain();
          return Right(data);
        } else {
          return Left(Failure(code: 0, message: response.message ?? ""));
        }
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }
}
