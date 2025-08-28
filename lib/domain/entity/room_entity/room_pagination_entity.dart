import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';

class RoomPaginationEntity {
  List<RoomEntity> data;
  PaginationEntity pagination;

  RoomPaginationEntity({
    required this.data,
    required this.pagination,
  });
}
