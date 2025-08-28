import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/domain/entity/app_entity/country_entity.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/auth_entity/privileges_entity.dart';
part 'user_entity.g.dart';

class UserFriendEntity {
  int count;
  UserPaginationEntity list;

  UserFriendEntity({
    required this.count,
    required this.list,
  });
}

class UserPaginationEntity {
  List<UserEntity> data;
  PaginationEntity pagination;

  UserPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

@JsonSerializable()
class UserEntity {
  int id;
  int userID;
  num referenceId;
  num goldValue;
  String name;
  String profileImg;
  String profileCover;
  String gender;
  CountryEntity country;
  num age;
  num profileLevel;
  String profileDescription;
  String appLang;
  num joinedDays;
  String birthDate;
  num friendsCount;
  num followers;
  num followings;
  num chatroomCount;
  String visitorsCount;
  bool isFriend;
  bool isFollow;
  @JsonKey(defaultValue: false)
  bool isFollowing;
  bool isBlocked;
  bool hasFriendRequest;
  String token;
  String type;
  List<String> badges;
  PrivilegesEntity privileges;
  num postsCount;
  int chatRoomId;
  String lockCode;
  int onlineUsersCount;
  String total;
  int chatId;
  String phone;
  String email;
  String profile;
  String track;
  String comment;
  String story;
  int friendId;
  @JsonKey(defaultValue: "")
  String backgroundTheme;

  UserEntity({
    required this.id,
    required this.userID,
    required this.name,
    required this.profileImg,
    required this.token,
    required this.type,
    required this.gender,
    required this.country,
    required this.followers,
    required this.age,
    required this.appLang,
    required this.chatroomCount,
    required this.followings,
    required this.friendsCount,
    required this.hasFriendRequest,
    required this.isBlocked,
    required this.isFollow,
    required this.isFollowing,
    required this.isFriend,
    required this.joinedDays,
    required this.profileCover,
    required this.profileDescription,
    required this.profileLevel,
    required this.referenceId,
    required this.visitorsCount,
    required this.badges,
    required this.privileges,
    required this.birthDate,
    required this.postsCount,
    required this.goldValue,
    required this.onlineUsersCount,
    required this.chatRoomId,
    required this.lockCode,
    required this.total,
    required this.chatId,
    required this.phone,
    required this.email,
    required this.track,
    required this.story,
    required this.profile,
    required this.comment,
    required this.friendId,
    required this.backgroundTheme,
  });

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
