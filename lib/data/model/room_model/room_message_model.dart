import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/auth_model/privileges_model.dart';
part 'room_message_model.g.dart';

@JsonSerializable()
class RoomMessageModel {
  @JsonKey(name: "chat_room_id")
  String? chatRoomId;
  @JsonKey(name: "user_id")
  num? userId;
  String? role;
  @JsonKey(name: "refrence_id")
  num? refrenceId;
  @JsonKey(name: "user_name")
  String? userName;
  @JsonKey(name: "profile_img")
  String? profileImg;
  String? message;
  PrivilegesModel? privileges;
  List<String>? badges;
  String? image;

  RoomMessageModel({
    this.message,
    this.userName,
    this.role,
    this.profileImg,
    this.image,
    this.badges,
    this.privileges,
    this.chatRoomId,
    this.refrenceId,
    this.userId,
  });

  factory RoomMessageModel.fromJson(Map<String, dynamic> json) =>
      _$RoomMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomMessageModelToJson(this);
}
