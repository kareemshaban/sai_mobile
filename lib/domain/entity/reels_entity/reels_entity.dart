import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/user_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';

class ReelsPaginationEntity {
  List<ReelsEntity> data;
  PaginationEntity pagination;

  ReelsPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

class ReelsEntity {
  int id;
  ChatUserInfoEntity user;
  String video;
  String createdAt;
  bool isComment;
  int countComments;
  int countViews;
  int countLikes;
  int countSaves;
  int countShare;
  String description;
  String location;
  List<String> tag;
  List<UserEntity> mentions;
  bool isView;
  bool isLike;
  bool isSave;
  bool isFriend;
  bool isFollow;
  bool isFollowing;
  String thumb;
  List<ReelsMediaEntity> media;
  String music;

  ReelsEntity({
    required this.id,
    required this.user,
    required this.createdAt,
    required this.description,
    required this.video,
    required this.countComments,
    required this.countShare,
    required this.countViews,
    required this.isComment,
    required this.location,
    required this.tag,
    required this.mentions,
    required this.isView,
    required this.isSave,
    required this.countSaves,
    required this.countLikes,
    required this.isLike,
    required this.isFriend,
    required this.thumb,
    required this.media,
    required this.music,
    required this.isFollow,
    required this.isFollowing,
  });
}

class ReelsMediaEntity {
  int id;
  String url;
  String type;
  String thump;

  ReelsMediaEntity({
    required this.id,
    required this.url,
    required this.type,
    required this.thump,
  });
}
