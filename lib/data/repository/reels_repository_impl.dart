import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/reels_data_source/reels_remote_data_source.dart';
import 'package:new_sai/data/mapper/reels_mapper.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/domain/repository/reels_repository.dart';

class ReelsRepositoryImpl extends ReelsRepository {
  final NetworkInfo _networkInfo;
  final ReelsRemoteDataSource _remoteDataSource;

  ReelsRepositoryImpl(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, ReelsPaginationEntity>> getReels(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getReels(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response.data.toDomain());
        } else {
          return Left(Failure(code: 0, message: response.message ?? ''));
        }
      } catch (e, stackTrace) {
        log(e.toString());
        log(stackTrace.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.noInternetConnection.getFailure());
    }
  }

  @override
  Future<Either<Failure, ReelsCommentPaginationEntity>> getReelsComment(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getReelsComment(params);
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
  Future<Either<Failure, ReelsCommentEntity>> reelsAddComment(
      ReelsCommentParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.reelsAddComment(params);
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
  Future<Either<Failure, dynamic>> likeReel(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.likeReel(params);
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
  Future<Either<Failure, dynamic>> saveReel(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.saveReel(params);
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
  Future<Either<Failure, ReelsPaginationEntity>> getSavedReels(
      int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getSavedReels(params);
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
  Future<Either<Failure, ReelsPaginationEntity>> getUserReels(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUserReels(params);
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
  Future<Either<Failure, BaseMapModel>> addReels(AddStoryParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addReels(params);
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
  Future<Either<Failure, ReelsEntity>> showReels(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.showReels(params);
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
  Future<Either<Failure, BaseMapModel>> deleteReels(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.deleteReels(params);
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
  Future<Either<Failure, BaseMapModel>> shareReels(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.shareReels(params);
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
}
