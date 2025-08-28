import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';

class MessagesPaginationEntity {
  List<MessagesEntity> data;
  PaginationEntity pagination;

  MessagesPaginationEntity({
    required this.pagination,
    required this.data,
  });
}

class MessagesEntity {
  int id;
  int chatId;
  int fromId;
  int toId;
  String type;
  String file;
  String statue;
  String message;
  String createdAt;
  String updatedAt;
  ChatUserInfoEntity userInfo;

  MessagesEntity({
    required this.id,
    required this.chatId,
    required this.fromId,
    required this.toId,
    required this.type,
    required this.statue,
    required this.message,
    required this.createdAt,
    required this.updatedAt,
    required this.userInfo,
    required this.file,
  });
}
