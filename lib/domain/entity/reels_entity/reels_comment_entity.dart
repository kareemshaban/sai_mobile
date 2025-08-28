import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';

class ReelsCommentPaginationEntity {
  List<ReelsCommentEntity> data;
  PaginationEntity pagination;

  ReelsCommentPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

class ReelsCommentEntity {
  int id;
  String comment;
  ChatUserInfoEntity user;
  String createdAt;

  ReelsCommentEntity({
    required this.id,
    required this.comment,
    required this.user,
    required this.createdAt,
  });
}
