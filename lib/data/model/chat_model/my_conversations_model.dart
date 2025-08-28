import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
part 'my_conversations_model.g.dart';

@JsonSerializable()
class MyConversationsModelPagination {
  List<MyConversationsModel>? data;
  PaginationModel? pagination;

  MyConversationsModelPagination({
    this.data,
    this.pagination,
  });

  factory MyConversationsModelPagination.fromJson(Map<String, dynamic> json) =>
      _$MyConversationsModelPaginationFromJson(json);

  Map<String, dynamic> toJson() => _$MyConversationsModelPaginationToJson(this);
}

@JsonSerializable()
class MyConversationsModel {
  int? id;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "last_message_time")
  String? lastMessageTime;
  String? message;
  String? file;
  String? type;
  @JsonKey(name: "to_id")
  int? toId;
  @JsonKey(name: "user_info")
  ChatUserInfoModel? userInfo;
  @JsonKey(name: "messages_count")
  int? messagesCount;

  MyConversationsModel({
    this.message,
    this.id,
    this.createdAt,
    this.lastMessageTime,
    this.messagesCount,
    this.toId,
    this.userInfo,
    this.type,
    this.file,
  });

  factory MyConversationsModel.fromJson(Map<String, dynamic> json) =>
      _$MyConversationsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyConversationsModelToJson(this);
}
