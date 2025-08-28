import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/country_model.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/auth_model/privileges_model.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserFriendModel {
  int? count;
  UserPaginationModel? list;

  UserFriendModel({
    this.count,
    this.list,
  });

  factory UserFriendModel.fromJson(Map<String, dynamic> json) =>
      _$UserFriendModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserFriendModelToJson(this);
}

@JsonSerializable()
class UserPaginationModel {
  List<UserModel>? data;
  PaginationModel? pagination;

  UserPaginationModel({
    this.data,
    this.pagination,
  });

  factory UserPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$UserPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserPaginationModelToJson(this);
}

@JsonSerializable()
class UserModel {
  int? id;
  @JsonKey(name: "user_id")
  int? userID;
  @JsonKey(name: "reference_id")
  num? referenceId;
  String? name;
  @JsonKey(name: "profile_img")
  String? profileImg;
  @JsonKey(name: "profile_cover")
  String? profileCover;
  String? gender;
  CountryModel? country;
  num? age;
  @JsonKey(name: "profile_level")
  num? profileLevel;
  @JsonKey(name: "profile_description")
  String? profileDescription;
  @JsonKey(name: "app_lang")
  String? appLang;
  @JsonKey(name: "joined_days")
  num? joinedDays;
  @JsonKey(name: "birth_date")
  String? birthDate;
  @JsonKey(name: "friends_count")
  num? friendsCount;
  num? followers;
  num? followings;
  @JsonKey(name: "chatroom_count")
  num? chatroomCount;
  @JsonKey(name: "visitors_count")
  String? visitorsCount;
  @JsonKey(name: "is_friend")
  bool? isFriend;
  @JsonKey(name: "is_follow")
  bool? isFollow;
  @JsonKey(name: "is_following")
  bool? isFollowing;
  @JsonKey(name: "is_blocked")
  bool? isBlocked;
  @JsonKey(name: "has_friend_request")
  bool? hasFriendRequest;
  String? token;
  String? type;
  List<String>? badges;
  PrivilegesModel? privileges;
  @JsonKey(name: "posts_count")
  num? postsCount;
  @JsonKey(name: "gold_value")
  num? goldValue;
  @JsonKey(name: "chat_room_id")
  int? chatRoomId;
  @JsonKey(name: "chat_id")
  int? chatId;
  @JsonKey(name: "lock_code")
  String? lockCode;
  @JsonKey(name: "online_users_count")
  int? onlineUsersCount;
  @JsonKey(name: "totla")
  String? total;
  String? phone;
  String? email;
  String? profile;
  String? track;
  String? comment;
  String? story;
  @JsonKey(name: "friend_id")
  int? friendId;
  @JsonKey(name: "background_theme")
  String? backgroundTheme;

  UserModel({
    this.id,
    this.userID,
    this.name,
    this.profileImg,
    this.token,
    this.type,
    this.gender,
    this.country,
    this.followers,
    this.age,
    this.appLang,
    this.chatroomCount,
    this.followings,
    this.friendsCount,
    this.hasFriendRequest,
    this.isBlocked,
    this.isFollow,
    this.isFriend,
    this.isFollowing,
    this.joinedDays,
    this.profileCover,
    this.profileDescription,
    this.profileLevel,
    this.referenceId,
    this.visitorsCount,
    this.badges,
    this.privileges,
    this.birthDate,
    this.postsCount,
    this.goldValue,
    this.lockCode,
    this.chatRoomId,
    this.onlineUsersCount,
    this.total,
    this.chatId,
    this.phone,
    this.email,
    this.comment,
    this.profile,
    this.story,
    this.track,
    this.friendId,
    this.backgroundTheme,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
