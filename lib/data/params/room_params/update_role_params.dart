import 'package:json_annotation/json_annotation.dart';
part 'update_role_params.g.dart';

@JsonSerializable()
class UpdateRoleParams {
  @JsonKey(name: "chat_room_id", includeIfNull: false)
  String? chatRoomId;
  @JsonKey(name: "user_id", includeIfNull: false)
  String? userId;
  @JsonKey(includeIfNull: false)
  String? role;

  UpdateRoleParams({
    this.role,
    this.userId,
    this.chatRoomId,
  });

  factory UpdateRoleParams.fromJson(Map<String, dynamic> json) =>
      _$UpdateRoleParamsFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRoleParamsToJson(this);
}
