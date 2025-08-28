import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/settings_data_source/settings_remote_data_source.dart';
import 'package:new_sai/data/mapper/settings_mapper.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/settings_params/change_email_phone_params.dart';
import 'package:new_sai/data/params/settings_params/change_password_params.dart';
import 'package:new_sai/data/params/settings_params/change_privacy_params.dart';
import 'package:new_sai/data/params/settings_params/get_settings_product_params.dart';
import 'package:new_sai/data/params/settings_params/report_params.dart';
import 'package:new_sai/domain/entity/settings_entity/premium_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/setting_market_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/settings_market_product_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/terms_privacy_entity.dart';
import 'package:new_sai/domain/repository/settings_repository.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  final NetworkInfo _networkInfo;
  final SettingsRemoteDataSource _remoteDataSource;

  SettingsRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, PremiumEntity>> getPremiumList() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getPremiumList();
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
  Future<Either<Failure, dynamic>> activatePremiuem(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.activatePremium(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, dynamic>> renewPremiuem(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.renewPremium(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, SettingMarketEntity>> getSettingMarket() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getSettingMarket();
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
  Future<Either<Failure, List<SettingsMarketProductEntity>>>
      getSettingsMarketProduct(GetSettingsProductParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getSettingsMarketProduct(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data?.map((e) => e.toDomain()).toList() ?? []);
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
  Future<Either<Failure, SettingsMarketProductEntity>> buySettingsMarketProduct(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.buySettingsMarketProduct(params);
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
  Future<Either<Failure, bool>> seleceSettingsMarketProduct(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.seleceSettingsMarketProduct(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right(true);
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
  Future<Either<Failure, TermsPrivacyEntity>> getTermsAndPrivacy(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getTermsAndPrivacy(params);
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
  Future<Either<Failure, dynamic>> changePassword(
      ChangePasswordParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.changePassword(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, dynamic>> changeEmail(
      ChangeEmailPhoneParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.changeEmail(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, dynamic>> changePhone(
      ChangeEmailPhoneParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.changePhone(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, dynamic>> sendCodeToEmail(
      ChangeEmailPhoneParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.sendCodeToEmail(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, dynamic>> sendCodeToPhone(
      ChangeEmailPhoneParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.sendCodeToPhone(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, dynamic>> changePrivacy(
      ChangePrivacyParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.changePrivacy(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, dynamic>> report(ReportParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.report(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, bool>> updateLanguagdde(String newLanguage) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.updateLanguage(newLanguage);
        if (response.success == ApiInternalStatus.success) {
          return const Right(true);
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
}
