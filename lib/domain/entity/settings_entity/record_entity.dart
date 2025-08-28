import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';

class RecordPaginationEntity {
  List<RecordEntity> data;
  PaginationEntity pagination;

  RecordPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

class RecordEntity {
  int id;
  int toId;
  String user;
  num goldValue;
  String date;

  RecordEntity({
    required this.id,
    required this.toId,
    required this.user,
    required this.goldValue,
    required this.date,
  });
}
