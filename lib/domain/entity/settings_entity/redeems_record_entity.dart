import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';

class RedeemsRecordPaginationEntity {
  List<RedeemsRecordEntity> data;
  PaginationEntity pagination;

  RedeemsRecordPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

class RedeemsRecordEntity {
  int id;
  String date;
  num redeemTotal;

  RedeemsRecordEntity({
    required this.id,
    required this.date,
    required this.redeemTotal,
  });
}
