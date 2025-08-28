import 'package:new_sai/domain/entity/auth_entity/privileges_entity.dart';

class RoomUserEntity {
  num id;
  num referenceId;
  String name;
  String profileImg;
  num conversationId;
  String role;
  num level;
  bool isFriend;
  bool hasFriendRequest;
  num friendRequestId;
  bool sendFriendRequest;
  PrivilegesEntity privileges;
  List<String> badges;
  String supportReceivedVal;
  String supportSentVal;
  bool isFollow;
  bool isFollowing;

  RoomUserEntity({
    required this.referenceId,
    required this.id,
    required this.name,
    required this.profileImg,
    required this.privileges,
    required this.badges,
    required this.role,
    required this.isFriend,
    required this.isFollow,
    required this.hasFriendRequest,
    required this.conversationId,
    required this.friendRequestId,
    required this.level,
    required this.sendFriendRequest,
    required this.supportReceivedVal,
    required this.supportSentVal,
    required this.isFollowing,
  });
}
