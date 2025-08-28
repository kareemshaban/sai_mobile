import 'package:new_sai/domain/entity/auth_entity/privileges_entity.dart';

class RoomBannersEntity {
  List<RoomBannerItemEntity> topBillionares;
  List<RoomBannerItemEntity> topSenders;
  List<RoomBannerItemEntity> topRooms;

  RoomBannersEntity({
    required this.topBillionares,
    required this.topRooms,
    required this.topSenders,
  });
}

class RoomBannerItemEntity {
  String name;
  num userId;
  num referenceId;
  String profileImg;
  String gender;
  num age;
  num profileLevel;
  String totla;
  PrivilegesEntity privileges;
  num chatRoomId;
  String lockCode;
  num onlineUsersCount;

  RoomBannerItemEntity({
    required this.age,
    required this.referenceId,
    required this.profileImg,
    required this.gender,
    required this.profileLevel,
    required this.name,
    required this.privileges,
    required this.totla,
    required this.userId,
    required this.onlineUsersCount,
    required this.chatRoomId,
    required this.lockCode,
  });
}
