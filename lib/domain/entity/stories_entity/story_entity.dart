import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/chat_entity/chat_user_info_entity.dart';

class StoryPaginationEntity {
  List<StoryEntity> data;
  PaginationEntity pagination;

  StoryPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

class StoryEntity {
  int id;
  ChatUserInfoEntity user;
  List<StoryMediaEntity> media;
  String createdAt;
  String link;
  String location;
  bool isComment;
  String music;
  List<String> tag;
  String description;
  String title;

  StoryEntity({
    required this.id,
    required this.user,
    required this.media,
    required this.createdAt,
    required this.isComment,
    required this.music,
    required this.location,
    required this.link,
    required this.tag,
    required this.description,
    required this.title,
  });
}

class StoryMediaEntity {
  int id;
  String url;
  String type;
  int countComments;
  int countViews;
  int countShare;
  bool isView;
  bool isLike;
  bool isSave;
  bool isFriend;
  String thump;

  StoryMediaEntity({
    required this.id,
    required this.type,
    required this.url,
    required this.countShare,
    required this.countViews,
    required this.countComments,
    required this.isFriend,
    required this.isSave,
    required this.isLike,
    required this.isView,
    required this.thump,
  });
}
