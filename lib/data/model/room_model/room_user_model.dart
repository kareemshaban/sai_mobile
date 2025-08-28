import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/auth_model/privileges_model.dart';
part 'room_user_model.g.dart';

@JsonSerializable()
class RoomUserModel {
  @JsonKey(name: "user_id")
  num? id;
  @JsonKey(name: "reference_id")
  num? referenceId;
  @JsonKey(name: "user_name")
  String? name;
  @JsonKey(name: "profile_img")
  String? profileImg;
  @JsonKey(name: "conversation_id")
  num? conversationId;
  String? role;
  num? level;
  @JsonKey(name: "is_friend")
  bool? isFriend;
  @JsonKey(name: "has_friend_request")
  bool? hasFriendRequest;
  @JsonKey(name: "friend_request_id")
  num? friendRequestId;
  @JsonKey(name: "send_friend_request")
  bool? sendFriendRequest;
  PrivilegesModel? privileges;
  List<String>? badges;
  @JsonKey(name: "support_received_val")
  String? supportReceivedVal;
  @JsonKey(name: "support_sent_val")
  String? supportSentVal;
  @JsonKey(name: "is_follow")
  bool? isFollow;
  @JsonKey(name: "is_following")
  bool? isFollowing;

  RoomUserModel({
    this.referenceId,
    this.id,
    this.name,
    this.profileImg,
    this.privileges,
    this.badges,
    this.role,
    this.isFriend,
    this.isFollow,
    this.hasFriendRequest,
    this.conversationId,
    this.friendRequestId,
    this.level,
    this.sendFriendRequest,
    this.supportReceivedVal,
    this.supportSentVal,
    this.isFollowing,
  });

  factory RoomUserModel.fromJson(Map<String, dynamic> json) =>
      _$RoomUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$RoomUserModelToJson(this);
}
