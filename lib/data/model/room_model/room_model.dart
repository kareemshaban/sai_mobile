import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/room_model/tag_model.dart';
part 'room_model.g.dart';

@JsonSerializable()
class RoomModel {
  int? id;
  @JsonKey(name: "room_reference_id")
  num? roomReferenceId;
  @JsonKey(name: "room_image")
  String? roomImage;
  String? falg;
  @JsonKey(name: "room_name")
  String? roomName;
  @JsonKey(name: "general_notification_content")
  String? generalNotificationContent;
  TagModel? tag;
  @JsonKey(name: "members_count")
  num? membersCount;
  @JsonKey(name: "profile_level")
  num? profileLevel;
  @JsonKey(name: "lock_code")
  String? lockCode;
  @JsonKey(name: "background_theme")
  String? backgroundTheme;

  RoomModel({
    this.id,
    this.roomReferenceId,
    this.roomImage,
    this.roomName,
    this.generalNotificationContent,
    this.tag,
    this.membersCount,
    this.profileLevel,
    this.lockCode,
    this.falg,
    this.backgroundTheme,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomModelToJson(this);
}
