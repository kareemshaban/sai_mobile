import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';

abstract class ReelsRepository {
  Future<Either<Failure, ReelsPaginationEntity>> getReels(dynamic params);
  Future<Either<Failure, ReelsCommentPaginationEntity>> getReelsComment(
      dynamic params);
  Future<Either<Failure, ReelsCommentEntity>> reelsAddComment(
      ReelsCommentParams params);
  Future<Either<Failure, dynamic>> likeReel(int params);
  Future<Either<Failure, dynamic>> saveReel(int params);
  Future<Either<Failure, ReelsPaginationEntity>> getSavedReels(int params);
  Future<Either<Failure, ReelsPaginationEntity>> getUserReels(dynamic params);
  Future<Either<Failure, BaseMapModel>> addReels(AddStoryParams params);
  Future<Either<Failure, ReelsEntity>> showReels(int params);
  Future<Either<Failure, BaseMapModel>> deleteReels(int params);
  Future<Either<Failure, BaseMapModel>> shareReels(int params);
}
