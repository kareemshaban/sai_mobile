import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/room_model/tag_model.dart';
part 'room_settings_model.g.dart';

@JsonSerializable()
class RoomSettingsModel {
  @JsonKey(name: "profile_image")
  String? profileImage;
  @JsonKey(name: "room_name")
  String? roomName;
  @JsonKey(name: "notification_content")
  String? notificationContent;
  @JsonKey(name: "tag_id")
  num? tagId;
  List<TagModel>? tags;
  @JsonKey(name: "membership_fee")
  num? membershipFee;
  @JsonKey(name: "microphones_count")
  num? microphonesCount;
  @JsonKey(name: "request_mic")
  String? requestMic;
  @JsonKey(name: "admin_lock_mic")
  num? adminLockMic;
  @JsonKey(name: "admin_request_mic")
  num? adminRequestMic;
  @JsonKey(name: "guest_join_room")
  num? guestJoinRoom;

  RoomSettingsModel({
    this.profileImage,
    this.roomName,
    this.notificationContent,
    this.tagId,
    this.tags,
    this.membershipFee,
    this.microphonesCount,
    this.adminLockMic,
    this.adminRequestMic,
    this.guestJoinRoom,
    this.requestMic,
  });

  factory RoomSettingsModel.fromJson(Map<String, dynamic> json) =>
      _$RoomSettingsModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomSettingsModelToJson(this);
}
