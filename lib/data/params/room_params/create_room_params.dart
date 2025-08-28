import 'package:json_annotation/json_annotation.dart';
part 'create_room_params.g.dart';

@JsonSerializable()
class CreateRoomParams {
  @JsonKey(name: "room_name", includeIfNull: false)
  String? roomName;
  @JsonKey(name: "room_image", includeIfNull: false)
  String? roomImage;
  @JsonKey(name: "general_notification_content", includeIfNull: false)
  String? generalNotificationContent;

  CreateRoomParams({
    this.roomName,
    this.roomImage,
    this.generalNotificationContent,
  });

  factory CreateRoomParams.fromJson(Map<String, dynamic> json) =>
      _$CreateRoomParamsFromJson(json);

  Map<String, dynamic> toJson() => _$CreateRoomParamsToJson(this);
}
