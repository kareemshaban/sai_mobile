import 'package:json_annotation/json_annotation.dart';
part 'update_room_settings_params.g.dart';

@JsonSerializable()
class UpdateRoomSettingsParams {
  @JsonKey(includeFromJson: false, includeToJson: false)
  String? roomID;
  @JsonKey(name: "profile_img", includeIfNull: false)
  String? profileImage;
  @JsonKey(name: "room_name", includeIfNull: false)
  String? roomName;
  @JsonKey(name: "general_notification", includeIfNull: false)
  String? notificationContent;
  @JsonKey(name: "membership_fee", includeIfNull: false)
  num? membershipFee;
  @JsonKey(name: "miccount", includeIfNull: false)
  num? microphonesCount;
  @JsonKey(name: "request_mic", includeIfNull: false)
  String? requestMic;
  @JsonKey(name: "admin_lock_mic", includeIfNull: false)
  num? adminLockMic;
  @JsonKey(name: "admin_request_mic", includeIfNull: false)
  num? adminRequestMic;
  @JsonKey(name: "guest_join_room", includeIfNull: false)
  num? guestJoinRoom;

  UpdateRoomSettingsParams({
    this.profileImage,
    this.roomName,
    this.notificationContent,
    this.membershipFee,
    this.microphonesCount,
    this.adminLockMic,
    this.adminRequestMic,
    this.guestJoinRoom,
    this.requestMic,
    this.roomID,
  });

  factory UpdateRoomSettingsParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateRoomSettingsParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRoomSettingsParamsToJson(this);

  UpdateRoomSettingsParams copyWith({
    String? roomID,
    String? roomName,
    num? adminLockMic,
    num? adminRequestMic,
    num? guestJoinRoom,
    num? membershipFee,
    num? microphonesCount,
    String? notificationContent,
    String? profileImage,
    String? requestMic,
  }) {
    return UpdateRoomSettingsParams(
      roomID: roomID ?? this.roomID,
      roomName: roomName ?? this.roomName,
      adminLockMic: adminLockMic ?? this.adminLockMic,
      adminRequestMic: adminRequestMic ?? this.adminRequestMic,
      guestJoinRoom: guestJoinRoom ?? this.guestJoinRoom,
      membershipFee: membershipFee ?? this.membershipFee,
      microphonesCount: microphonesCount ?? this.microphonesCount,
      notificationContent: notificationContent ?? this.notificationContent,
      profileImage: profileImage ?? this.profileImage,
      requestMic: requestMic ?? this.requestMic,
    );
  }
}
