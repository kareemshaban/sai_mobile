import 'package:dartz/dartz.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/network/failure.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_comment_entity.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';

abstract class StoriesRepository {
  Future<Either<Failure, BaseMapModel>> addStory(AddStoryParams parameters);
  Future<Either<Failure, StoryPaginationEntity>> getUserStories(dynamic params);
  Future<Either<Failure, ReelsCommentPaginationEntity>> getStoryComment(
      dynamic params);
  Future<Either<Failure, ReelsCommentPaginationEntity>> getStoryViews(
      dynamic params);
  Future<Either<Failure, BaseMapModel>> commentOnStory(
      ReelsCommentParams params);
  Future<Either<Failure, dynamic>> showStory(int params);
  Future<Either<Failure, StoryEntity>> getStoryByID(int params);
  Future<Either<Failure, BaseMapModel>> deleteStory(int params);
}
