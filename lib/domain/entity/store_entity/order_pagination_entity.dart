import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/order_entity.dart';

class OrderPaginationEntity {
  List<OrderEntity> data;
  PaginationEntity pagination;

  OrderPaginationEntity({
    required this.pagination,
    required this.data,
  });
}
