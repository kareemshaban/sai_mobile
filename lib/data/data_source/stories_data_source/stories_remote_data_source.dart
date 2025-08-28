import 'package:dio/dio.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/reels_model/reels_comment_model.dart';
import 'package:new_sai/data/model/story_model/story_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';

abstract class StoriesRemoteDataSource {
  Future<BaseMapModel> addStory(AddStoryParams parameters);
  Future<BaseMapModel<StoryPaginationModel>> getUserStories(dynamic params);
  Future<BaseMapModel<ReelsCommentPaginationModel>> getStoryComment(
      dynamic params);
  Future<BaseMapModel<ReelsCommentPaginationModel>> getStoryViews(
      dynamic params);
  Future<BaseMapModel> commentOnStory(ReelsCommentParams params);
  Future<BaseMapModel> showStory(int params);
  Future<BaseMapModel<StoryModel>> getStoryByID(int params);
  Future<BaseMapModel> deleteStory(int params);
}

class StoriesremoteDataSourceImpl extends StoriesRemoteDataSource {
  final AppServiceClient _appServiceClient;

  StoriesremoteDataSourceImpl(this._appServiceClient);
  @override
  Future<BaseMapModel> addStory(AddStoryParams parameters) async {
    List<Map<String, dynamic>> files = [];
    for (var image in parameters.images) {
      files.add({
        'file': await MultipartFile.fromFile(image.file),
        'type': 'image',
      });
    }
    for (var video in parameters.videos) {
      files.add({
        'file': await MultipartFile.fromFile(video.file),
        'type': 'video',
        if (video.thump != null)
          'thump': await MultipartFile.fromFile(video.thump!),
      });
    }
    var formData = FormData.fromMap(
      {
        "media": files,
        "is_comment": parameters.canComment ? 1 : 0,
        "view_state": parameters.viewState,
        "location": parameters.location,
        "description": parameters.description,
        if (parameters.music != null)
          "music": await MultipartFile.fromFile(parameters.music!),
        "link": parameters.link,
        "tag": parameters.hashTags ?? [],
        "mention_users": parameters.mentionsIds ?? []
      },
      ListFormat.multiCompatible,
    );
    return await _appServiceClient.performPostRequest(
        EndPoint.addStory, formData, (value) => BaseMapModel.fromJson);
  }

  @override
  Future<BaseMapModel<StoryPaginationModel>> getUserStories(
      dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.userStories(params['id']),
      StoryPaginationModel.fromJson,
      params: {
        "page": params['page'],
      },
    );
  }

  @override
  Future<BaseMapModel<ReelsCommentPaginationModel>> getStoryComment(
      dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.storyComment(params['id']),
      ReelsCommentPaginationModel.fromJson,
      params: {
        "page": params['page'],
      },
    );
  }

  @override
  Future<BaseMapModel<ReelsCommentPaginationModel>> getStoryViews(
      dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.storyViews(params['id']),
      ReelsCommentPaginationModel.fromJson,
      params: {
        "page": params['page'],
      },
    );
  }

  @override
  Future<BaseMapModel> commentOnStory(ReelsCommentParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.addComment(params.id!),
      params.toJson(),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> showStory(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.showStory(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<StoryModel>> getStoryByID(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.storyByID(params),
      StoryModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> deleteStory(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.deleteStory(params),
      (value) => null,
    );
  }
}
