import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:new_sai/data/data_source/stories_data_source/stories_remote_data_source.dart';
import 'package:new_sai/data/mapper/reels_mapper.dart';
import 'package:new_sai/data/mapper/story_mapper.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/error_handler.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/network/network_info.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/domain/repository/stories_repository.dart';

class StoriesRepositoryImpl extends StoriesRepository {
  final NetworkInfo _networkInfo;
  final StoriesRemoteDataSource _remoteDataSource;

  StoriesRepositoryImpl({
    required NetworkInfo networkInfo,
    required StoriesRemoteDataSource remoteDataSource,
  })  : _networkInfo = networkInfo,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, BaseMapModel>> addStory(
      AddStoryParams parameters) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.addStory(parameters);
        if (response.success == ApiInternalStatus.success) {
          return Right(response);
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
  Future<Either<Failure, StoryPaginationEntity>> getUserStories(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getUserStories(params);
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
  Future<Either<Failure, ReelsCommentPaginationEntity>> getStoryComment(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getStoryComment(params);
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
  Future<Either<Failure, ReelsCommentPaginationEntity>> getStoryViews(
      dynamic params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getStoryViews(params);
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
  Future<Either<Failure, BaseMapModel>> commentOnStory(
      ReelsCommentParams params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.commentOnStory(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response);
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
  Future<Either<Failure, dynamic>> showStory(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.showStory(params);
        if (response.success == ApiInternalStatus.success) {
          return const Right("");
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
  Future<Either<Failure, StoryEntity>> getStoryByID(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getStoryByID(params);
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
  Future<Either<Failure, BaseMapModel>> deleteStory(int params) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.deleteStory(params);
        if (response.success == ApiInternalStatus.success) {
          return Right(response);
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
