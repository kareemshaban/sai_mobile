import 'package:dio/dio.dart';
import 'package:new_sai/data/model/app_model/base_model.dart';
import 'package:new_sai/data/model/chat_model/friend_request_model.dart';
import 'package:new_sai/data/model/chat_model/messages_model.dart';
import 'package:new_sai/data/model/chat_model/my_conversations_model.dart';
import 'package:new_sai/data/network/app_api.dart';
import 'package:new_sai/data/network/end_point.dart';
import 'package:new_sai/data/params/chat_params/fetch_messages_params.dart';
import 'package:new_sai/data/params/chat_params/send_message_params.dart';

abstract class ChatRemoteDataSource {
  Future<BaseMapModel<MyConversationsModelPagination>> getMyConversations(
      int params);
  Future<BaseMapModel<MessagesPaginationModel>> fetchMessages(
      FetchMessagesParams params);
  Future<BaseListModel> markAllAsRead(FetchMessagesParams params);
  Future<BaseListModel> sendMessage(SendMessageParams params);
  Future<BaseListModel> deliveredMessage(int params);
  Future<BaseMapModel<FriendRequestPaginationModel>> getFriendRequest(
      int params);
  Future<BaseMapModel> acceptFriendRequest(int params);
  Future<BaseMapModel> removeFriendRequest(int params);
  Future<BaseMapModel> deleteChat(int params);
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  final AppServiceClient _appServiceClient;
  ChatRemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseMapModel<MyConversationsModelPagination>> getMyConversations(
      int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.myConversation,
      MyConversationsModelPagination.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseMapModel<MessagesPaginationModel>> fetchMessages(
      FetchMessagesParams params) async {
    return await _appServiceClient.performPostRequest(
      EndPoint.fetchMessages(params),
      params.toJson(),
      MessagesPaginationModel.fromJson,
    );
  }

  @override
  Future<BaseListModel> markAllAsRead(FetchMessagesParams params) async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.markAllAsRead(params),
      (value) => null,
    );
  }

  @override
  Future<BaseListModel> sendMessage(SendMessageParams params) async {
    final data = FormData.fromMap(
      {
        if (params.recID != null) "rec_id": params.recID,
        if (params.type != null) "type": params.type,
        if (params.message != null) 'message': params.message!,
        if (params.file != null)
          "file": await MultipartFile.fromFile(params.file!),
      },
    );

    return await _appServiceClient.performPostRequestList(
      EndPoint.sendMessage,
      data,
      (value) => null,
    );
  }

  @override
  Future<BaseListModel> deliveredMessage(int params) async {
    return await _appServiceClient.performGetListRequest(
      EndPoint.deliveredMessage(params),
      (p0) => null,
    );
  }

  @override
  Future<BaseMapModel<FriendRequestPaginationModel>> getFriendRequest(
      int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.friendRequest,
      FriendRequestPaginationModel.fromJson,
      params: {
        "page": params,
      },
    );
  }

  @override
  Future<BaseMapModel> acceptFriendRequest(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.acceptFriend(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> removeFriendRequest(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.removeFriend(params),
      (value) => null,
    );
  }

  @override
  Future<BaseMapModel> deleteChat(int params) async {
    return await _appServiceClient.performGetRequest(
      EndPoint.deleteChat(params),
      (p0) => null,
    );
  }
}
