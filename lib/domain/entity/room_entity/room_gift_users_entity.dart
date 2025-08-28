import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';

class RoomGiftUsersEntityPagination {
  List<RoomGiftUsersEntity> data;
  PaginationEntity pagination;

  RoomGiftUsersEntityPagination({
    required this.data,
    required this.pagination,
  });
}

class RoomGiftUsersEntity {
  int fromId;
  String userName;
  String userImage;
  String totalPrice;
  num giftsCount;
  num referenceId;
  List<String> badges;

  RoomGiftUsersEntity({
    required this.userName,
    required this.fromId,
    required this.giftsCount,
    required this.totalPrice,
    required this.userImage,
    required this.referenceId,
    required this.badges,
  });
}
