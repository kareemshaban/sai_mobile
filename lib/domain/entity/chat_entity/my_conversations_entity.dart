import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';

import 'chat_user_info_entity.dart';

class MyConversationsEntityPagination {
  List<MyConversationsEntity> data;
  PaginationEntity pagination;

  MyConversationsEntityPagination({
    required this.data,
    required this.pagination,
  });
}

class MyConversationsEntity {
  int id;
  String createdAt;
  String lastMessageTime;
  String message;
  String file;
  String type;
  int toId;
  ChatUserInfoEntity userInfo;
  int messagesCount;

  MyConversationsEntity({
    required this.message,
    required this.id,
    required this.createdAt,
    required this.lastMessageTime,
    required this.messagesCount,
    required this.toId,
    required this.userInfo,
    required this.type,
    required this.file,
  });

  static final fakeData = MyConversationsEntity(
    message: "message message message message",
    id: 0,
    createdAt: "createdAt",
    lastMessageTime: "lastMessageTime",
    messagesCount: 0,
    toId: 0,
    type: "",
    file: "",
    userInfo:
        ChatUserInfoEntity(id: 0, name: "name", logo: "logo", referenceId: 0),
  );
}
