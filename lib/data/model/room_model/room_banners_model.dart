import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/auth_model/privileges_model.dart';
part 'room_banners_model.g.dart';

@JsonSerializable()
class RoomBannersModel {
  @JsonKey(name: "top_billionares")
  List<RoomBannerItemModel>? topBillionares;
  @JsonKey(name: "top_senders")
  List<RoomBannerItemModel>? topSenders;
  @JsonKey(name: "top_rooms")
  List<RoomBannerItemModel>? topRooms;

  RoomBannersModel({
    this.topBillionares,
    this.topRooms,
    this.topSenders,
  });

  factory RoomBannersModel.fromJson(Map<String, dynamic> json) =>
      _$RoomBannersModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomBannersModelToJson(this);
}

@JsonSerializable()
class RoomBannerItemModel {
  String? name;
  @JsonKey(name: "user_id")
  num? userId;
  @JsonKey(name: "reference_id")
  num? referenceId;
  @JsonKey(name: "profile_img")
  String? profileImg;
  String? gender;
  num? age;
  @JsonKey(name: "profile_level")
  num? profileLevel;
  String? totla;
  PrivilegesModel? privileges;
  @JsonKey(name: "chat_room_id")
  num? chatRoomId;
  @JsonKey(name: "lock_code")
  String? lockCode;
  @JsonKey(name: "online_users_count")
  num? onlineUsersCount;

  RoomBannerItemModel({
    this.age,
    this.referenceId,
    this.profileImg,
    this.gender,
    this.profileLevel,
    this.name,
    this.privileges,
    this.totla,
    this.userId,
    this.onlineUsersCount,
    this.chatRoomId,
    this.lockCode,
  });

  factory RoomBannerItemModel.fromJson(Map<String, dynamic> json) =>
      _$RoomBannerItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomBannerItemModelToJson(this);
}
