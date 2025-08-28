import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/notification_data_source/notification_remote_data_source.dart';
import 'package:new_sai/data/mapper/notification_mapper.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/domain/entity/notification_entity/notification_entity.dart';
import 'package:new_sai/domain/entity/notification_entity/un_read_notification_count_entity.dart';
import 'package:new_sai/domain/repository/notification_repository.dart';

class NotificationRepositoryImpl extends NotificationRepository {
  final NotificationRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  NotificationRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, NotificationPaginationEntity>> getNotification(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getNotification(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
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
  Future<Either<Failure, dynamic>> markAllAsRead() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.markAllAsRead();
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
  Future<Either<Failure, UnReadNotificationCountEntity>>
      getNotificationCount() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getNotificationCount();
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
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
  Future<Either<Failure, dynamic>> deleteAllNotifications() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.deleteAllNotifications();
        if (response.success == ApiInternalStatus.success) {
          return const Right('');
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
