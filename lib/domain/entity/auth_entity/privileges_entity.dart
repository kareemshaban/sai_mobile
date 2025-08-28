import 'package:json_annotation/json_annotation.dart';
part 'privileges_entity.g.dart';

@JsonSerializable()
class PrivilegesEntity {
  @JsonKey(name: "category_id")
  int categoryId;
  @JsonKey(name: "category_name")
  String categoryName;
  @JsonKey(name: "category_icon")
  String categoryIcon;
  PrivilegesDataEntity data;

  PrivilegesEntity({
    required this.categoryId,
    required this.categoryName,
    required this.categoryIcon,
    required this.data,
  });

  factory PrivilegesEntity.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesEntityToJson(this);
}

@JsonSerializable()
class PrivilegesDataEntity {
  @JsonKey(name: "Badge Premium")
  PrivilegesDataItemEntity badgePremium;
  @JsonKey(name: "Entry with influences")
  PrivilegesDataItemEntity entryWithInfluences;
  @JsonKey(name: "Colorful name")
  PrivilegesDataItemEntity colorfulName;
  @JsonKey(name: "Exclusive gifts")
  PrivilegesDataItemEntity exclusiveGifts;
  @JsonKey(name: "Exclusive name card")
  PrivilegesDataItemEntity exclusiveNameCard;
  @JsonKey(name: "Friends count")
  PrivilegesDataItemEntity friendsCount;
  @JsonKey(name: "Profile frame")
  PrivilegesDataItemEntity profileFrame;
  @JsonKey(name: "Exclusive rooms box")
  PrivilegesDataItemEntity exclusiveChatBox;
  @JsonKey(name: "Profile cover")
  PrivilegesDataItemEntity profileCover;
  @JsonKey(name: "Chatroom lock")
  PrivilegesDataItemEntity chatroomLock;
  @JsonKey(name: "Luxury vehicles")
  PrivilegesDataItemEntity luxuryVehicles;
  @JsonKey(name: "disable mute and fiering")
  PrivilegesDataItemEntity disableMuteAndFiering;
  @JsonKey(name: "Profile border")
  PrivilegesDataItemEntity profileBorder;
  @JsonKey(name: "Room backcground")
  PrivilegesDataItemEntity roomBackcground;
  @JsonKey(name: "Profile card")
  PrivilegesDataItemEntity profileCard;

  PrivilegesDataEntity({
    required this.profileCover,
    required this.friendsCount,
    required this.badgePremium,
    required this.chatroomLock,
    required this.colorfulName,
    required this.disableMuteAndFiering,
    required this.entryWithInfluences,
    required this.exclusiveChatBox,
    required this.exclusiveGifts,
    required this.exclusiveNameCard,
    required this.luxuryVehicles,
    required this.profileBorder,
    required this.profileCard,
    required this.profileFrame,
    required this.roomBackcground,
  });

  factory PrivilegesDataEntity.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesDataEntityToJson(this);
}

@JsonSerializable()
class PrivilegesDataItemEntity {
  int id;
  String name;
  String file;
  String value;

  PrivilegesDataItemEntity({
    required this.name,
    required this.value,
    required this.id,
    required this.file,
  });

  factory PrivilegesDataItemEntity.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesDataItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesDataItemEntityToJson(this);
}
