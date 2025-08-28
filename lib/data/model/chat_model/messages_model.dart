import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/chat_model/chat_user_info_model.dart';
part 'messages_model.g.dart';

@JsonSerializable()
class MessagesPaginationModel {
  List<MessagesModel>? data;
  PaginationModel? pagination;

  MessagesPaginationModel({
    this.pagination,
    this.data,
  });

  factory MessagesPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesPaginationModelToJson(this);
}

@JsonSerializable()
class MessagesModel {
  int? id;
  @JsonKey(name: "chat_id")
  int? chatId;
  @JsonKey(name: "from_id")
  int? fromId;
  @JsonKey(name: "to_id")
  int? toId;
  String? type;
  String? file;
  String? statue;
  String? message;
  @JsonKey(name: "created_at")
  String? createdAt;
  @JsonKey(name: "updated_at")
  String? updatedAt;
  @JsonKey(name: "user_info")
  ChatUserInfoModel? userInfo;

  MessagesModel({
    this.id,
    this.chatId,
    this.fromId,
    this.toId,
    this.type,
    this.statue,
    this.message,
    this.createdAt,
    this.updatedAt,
    this.userInfo,
    this.file,
  });

  factory MessagesModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesModelFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesModelToJson(this);
}
