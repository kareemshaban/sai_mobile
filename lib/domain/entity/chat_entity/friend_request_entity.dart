import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';

class FriendRequestPaginationEntity {
  List<FriendRequestEntity> data;
  PaginationEntity pagination;

  FriendRequestPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

class FriendRequestEntity {
  int id;
  num referenceId;
  String name;
  String profileImg;
  num profileLevel;
  String description;
  num friendId;
  num isFriendAccepted;

  FriendRequestEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.friendId,
    required this.isFriendAccepted,
    required this.profileImg,
    required this.profileLevel,
    required this.referenceId,
  });
}
