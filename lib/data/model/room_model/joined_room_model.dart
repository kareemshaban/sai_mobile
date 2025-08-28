import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/auth_model/privileges_model.dart';
import 'package:new_sai/data/model/room_model/room_settings_model.dart';
part 'joined_room_model.g.dart';

@JsonSerializable()
class JoinedRoomModel {
  num? id;
  num? maxuser;
  @JsonKey(name: "reference_id")
  num? referenceId;
  @JsonKey(name: "owner_id")
  num? ownerId;
  @JsonKey(name: "total_gold")
  String? totalGold;
  @JsonKey(name: "room_image")
  String? roomImage;
  @JsonKey(name: "room_name")
  String? roomName;
  @JsonKey(name: "general_notification_content")
  String? generalNotificationContent;
  @JsonKey(name: "hello_mesaage")
  String? helloMesaage;
  @JsonKey(name: "user_message")
  String? userMessage;
  @JsonKey(name: "microphones_count")
  num? microphonesCount;
  @JsonKey(name: "is_blocked")
  num? isBlocked;
  @JsonKey(name: "is_fierd")
  bool? isFierd;
  RoomSettingsModel? settings;
  @JsonKey(name: "membership_fee")
  num? membershipFee;
  String? role;
  @JsonKey(name: "gold_value")
  num? goldValue;
  PrivilegesModel? privileges;
  List<String>? badges;
  @JsonKey(name: "background_theme")
  String? backgroundTheme;
  @JsonKey(name: "mic_statues")
  List<int>? micStatues;
  @JsonKey(name: "lock_code")
  String? lockCode;
  @JsonKey(name: "zego-token")
  String? zegoToken;

  JoinedRoomModel({
    this.generalNotificationContent,
    this.roomImage,
    this.roomName,
    this.privileges,
    this.referenceId,
    this.id,
    this.badges,
    this.isBlocked,
    this.settings,
    this.goldValue,
    this.helloMesaage,
    this.isFierd,
    this.maxuser,
    this.membershipFee,
    this.microphonesCount,
    this.ownerId,
    this.role,
    this.totalGold,
    this.userMessage,
    this.backgroundTheme,
    this.micStatues,
    this.lockCode,
    this.zegoToken,
  });

  factory JoinedRoomModel.fromJson(Map<String, dynamic> json) =>
      _$JoinedRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$JoinedRoomModelToJson(this);
}
