import 'package:dio/dio.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/reels_model/reels_comment_model.dart';
import 'package:new_sai/data/model/reels_model/reels_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/reels_params/reels_comment_params.dart';
import 'package:new_sai/data/params/story_params/add_story_params.dart';

abstract class ReelsRemoteDataSource {
  Future<BaseMapModel<ReelsPaginationModel>> getReels(dynamic params);
  Future<BaseMapModel<ReelsCommentPaginationModel>> getReelsComment(
      dynamic params);
  Future<BaseMapModel<ReelsCommentModel>> reelsAddComment(
      ReelsCommentParams params);
  Future<BaseMapModel> likeReel(int params);
  Future<BaseMapModel> saveReel(int params);
  Future<BaseMapModel<ReelsPaginationModel>> getSavedReels(int params);
  Future<BaseMapModel<ReelsPaginationModel>> getUserReels(dynamic params);
  Future<BaseMapModel> addReels(AddStoryParams params);
  Future<BaseMapModel<ReelsModel>> showReels(int params);
  Future<BaseMapModel> deleteReels(int params);
  Future<BaseMapModel> shareReels(int params);
}

class ReelsRemoteDataSourceImpl extends ReelsRemoteDataSource {
  final AppServiceClient _appServiceClient;
  ReelsRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<ReelsPaginationModel>> getReels(dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.reels,
      ReelsPaginationModel.fromJson,
      params: {
        "is_friend": params['is_friend'],
        "page": params['page'],
      },
    );
  }

  @override
  Future<BaseMapModel<ReelsCommentPaginationModel>> getReelsComment(
      dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.reelsComment(params['id']),
      ReelsCommentPaginationModel.fromJson,
      params: {"page": params['page']},
    );
  }

  @override
  Future<BaseMapModel<ReelsCommentModel>> reelsAddComment(
      ReelsCommentParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.reelsAddComment(params.id!),
      params.toJson(),
      ReelsCommentModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> likeReel(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.likeReel(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> saveReel(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.saveReel(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<ReelsPaginationModel>> getSavedReels(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.savedReels,
      ReelsPaginationModel.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseMapModel<ReelsPaginationModel>> getUserReels(
      dynamic params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.userReels(params['id']),
      ReelsPaginationModel.fromJson,
      params: {
        "page": params['page'],
      },
    );
  }

  @override
  Future<BaseMapModel> addReels(AddStoryParams params) async {
    List<Map<String, dynamic>> files = [];
    for (var image in params.images) {
      files.add({
        'file': await MultipartFile.fromFile(image.file),
        'type': 'image',
      });
    }
    for (var video in params.videos) {
      files.add({
        'file': await MultipartFile.fromFile(video.file),
        'type': 'video',
        if (video.thump != null)
          'thump': await MultipartFile.fromFile(video.thump!),
      });
    }
    var data = FormData.fromMap(
      {
        "media": files,
        "is_comment": params.canComment ? 1 : 0,
        "view_state": params.viewState,
        "location": params.location,
        "description": params.description,
        if (params.music != null)
          "music": await MultipartFile.fromFile(params.music!),
        "link": params.link,
        "tag": params.hashTags ?? [],
        "mention_users": params.mentionsIds ?? []
      },
      ListFormat.multiCompatible,
    );

    return await _appServiceClient.performPostRequest(
      EndPoint.postReels,
      data,
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel<ReelsModel>> showReels(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.showReels(params),
      ReelsModel.fromJson,
    );
  }

  @override
  Future<BaseMapModel> deleteReels(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.deleteReels(params),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel> shareReels(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.shareReels(params),
      (p0) => null,
    );
  }
}
