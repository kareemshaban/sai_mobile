import 'tag_entity.dart';

class RoomSettingsEntity {
  String profileImage;
  String roomName;
  String notificationContent;
  num tagId;
  List<TagEntity> tags;
  num membershipFee;
  num microphonesCount;
  String requestMic;
  num adminLockMic;
  num adminRequestMic;
  num guestJoinRoom;

  RoomSettingsEntity({
    required this.profileImage,
    required this.roomName,
    required this.notificationContent,
    required this.tagId,
    required this.tags,
    required this.membershipFee,
    required this.microphonesCount,
    required this.adminLockMic,
    required this.adminRequestMic,
    required this.guestJoinRoom,
    required this.requestMic,
  });
}
