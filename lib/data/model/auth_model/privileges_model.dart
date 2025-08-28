import 'package:json_annotation/json_annotation.dart';
part 'privileges_model.g.dart';

@JsonSerializable()
class PrivilegesModel {
  @JsonKey(name: "category_id")
  int? categoryId;
  @JsonKey(name: "category_name")
  String? categoryName;
  @JsonKey(name: "category_icon")
  String? categoryIcon;
  PrivilegesDataModel? data;

  PrivilegesModel({
    this.categoryId,
    this.categoryName,
    this.categoryIcon,
    this.data,
  });

  factory PrivilegesModel.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesModelToJson(this);
}

@JsonSerializable()
class PrivilegesDataModel {
  @JsonKey(name: "Badge Premium")
  PrivilegesDataItemModel? badgePremium;
  @JsonKey(name: "Entry with influences")
  PrivilegesDataItemModel? entryWithInfluences;
  @JsonKey(name: "Colorful name")
  PrivilegesDataItemModel? colorfulName;
  @JsonKey(name: "Exclusive gifts")
  PrivilegesDataItemModel? exclusiveGifts;
  @JsonKey(name: "Exclusive name card")
  PrivilegesDataItemModel? exclusiveNameCard;
  @JsonKey(name: "Friends count")
  PrivilegesDataItemModel? friendsCount;
  @JsonKey(name: "Profile frame")
  PrivilegesDataItemModel? profileFrame;
  @JsonKey(name: "Exclusive rooms box")
  PrivilegesDataItemModel? exclusiveChatBox;
  @JsonKey(name: "Profile cover")
  PrivilegesDataItemModel? profileCover;
  @JsonKey(name: "Chatroom lock")
  PrivilegesDataItemModel? chatroomLock;
  @JsonKey(name: "Luxury vehicles")
  PrivilegesDataItemModel? luxuryVehicles;
  @JsonKey(name: "disable mute and fiering")
  PrivilegesDataItemModel? disableMuteAndFiering;
  @JsonKey(name: "Profile border")
  PrivilegesDataItemModel? profileBorder;
  @JsonKey(name: "Room backcground")
  PrivilegesDataItemModel? roomBackcground;
  @JsonKey(name: "Profile card")
  PrivilegesDataItemModel? profileCard;

  PrivilegesDataModel({
    this.profileCover,
    this.friendsCount,
    this.badgePremium,
    this.chatroomLock,
    this.colorfulName,
    this.disableMuteAndFiering,
    this.entryWithInfluences,
    this.exclusiveChatBox,
    this.exclusiveGifts,
    this.exclusiveNameCard,
    this.luxuryVehicles,
    this.profileBorder,
    this.profileCard,
    this.profileFrame,
    this.roomBackcground,
  });

  factory PrivilegesDataModel.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesDataModelToJson(this);
}

@JsonSerializable()
class PrivilegesDataItemModel {
  int? id;
  String? name;
  String? file;
  String? value;

  PrivilegesDataItemModel({
    this.name,
    this.value,
    this.id,
    this.file,
  });

  factory PrivilegesDataItemModel.fromJson(Map<String, dynamic> json) =>
      _$PrivilegesDataItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$PrivilegesDataItemModelToJson(this);
}
