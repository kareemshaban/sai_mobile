import 'package:new_sai/domain/entity/auth_entity/privileges_entity.dart';

class RoomMessageEntity {
  String chatRoomId;
  num userId;
  String role;
  num refrenceId;
  String userName;
  String profileImg;
  String message;
  PrivilegesEntity privileges;
  List<String> badges;
  String image;

  RoomMessageEntity({
    required this.message,
    required this.userName,
    required this.role,
    required this.profileImg,
    required this.image,
    required this.badges,
    required this.privileges,
    required this.chatRoomId,
    required this.refrenceId,
    required this.userId,
  });
}
