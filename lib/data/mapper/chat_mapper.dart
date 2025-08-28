import 'package:new_sai/app/constants.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
import 'package:new_sai/data/model/chat_model/friend_request_model.dart';
import 'package:new_sai/data/model/chat_model/messages_model.dart';
import 'package:new_sai/data/model/chat_model/my_conversations_model.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/friend_request_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/messages_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/my_conversations_entity.dart';

extension MyConversationsPaginationMapper on MyConversationsModelPagination? {
  MyConversationsEntityPagination toDomain() {
    return MyConversationsEntityPagination(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension MyConversationsMapper on MyConversationsModel? {
  MyConversationsEntity toDomain() {
    return MyConversationsEntity(
      message: this?.message ?? Constants.empty,
      id: this?.id ?? Constants.zero,
      createdAt: this?.createdAt ?? Constants.empty,
      lastMessageTime: this?.lastMessageTime ?? Constants.empty,
      messagesCount: this?.messagesCount ?? Constants.zero,
      toId: this?.toId ?? Constants.zero,
      userInfo: this?.userInfo?.toDomain() ?? ChatUserInfoModel().toDomain(),
      type: this?.type ?? Constants.empty,
      file: this?.file ?? Constants.empty,
    );
  }
}

extension ChatUserInfoMapper on ChatUserInfoModel? {
  ChatUserInfoEntity toDomain() {
    return ChatUserInfoEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      logo: this?.logo ?? Constants.empty,
      referenceId: this?.referenceId ?? Constants.zero,
    );
  }
}

extension MessagesPaginationMapper on MessagesPaginationModel? {
  MessagesPaginationEntity toDomain() {
    return MessagesPaginationEntity(
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
    );
  }
}

extension MessagesMapper on MessagesModel? {
  MessagesEntity toDomain() {
    return MessagesEntity(
      id: this?.id ?? Constants.zero,
      chatId: this?.chatId ?? Constants.zero,
      fromId: this?.fromId ?? Constants.zero,
      toId: this?.toId ?? Constants.zero,
      type: this?.type ?? Constants.empty,
      statue: this?.statue ?? Constants.empty,
      message: this?.message ?? Constants.empty,
      createdAt: this?.createdAt ?? Constants.empty,
      updatedAt: this?.updatedAt ?? Constants.empty,
      file: this?.file ?? Constants.empty,
      userInfo: this?.userInfo.toDomain() ?? ChatUserInfoModel().toDomain(),
    );
  }
}

extension FriendRequestPaginationMapper on FriendRequestPaginationModel? {
  FriendRequestPaginationEntity toDomain() {
    return FriendRequestPaginationEntity(
      data: this?.data?.map((e) => e.toDomain()).toList() ?? [],
      pagination: this?.pagination?.toDomain() ?? PaginationModel().toDomain(),
    );
  }
}

extension FriendRequestMapper on FriendRequestModel? {
  FriendRequestEntity toDomain() {
    return FriendRequestEntity(
      id: this?.id ?? Constants.zero,
      name: this?.name ?? Constants.empty,
      description: this?.description ?? Constants.empty,
      friendId: this?.friendId ?? Constants.zero,
      isFriendAccepted: this?.isFriendAccepted ?? Constants.zero,
      profileImg: this?.profileImg ?? Constants.empty,
      profileLevel: this?.profileLevel ?? Constants.zero,
      referenceId: this?.referenceId ?? Constants.zero,
    );
  }
}
