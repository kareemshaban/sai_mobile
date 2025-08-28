import 'package:new_sai/app/enums.dart';
import 'package:new_sai/domain/entity/store_entity/market_entity.dart';

class OrderEntity {
  int id;
  MarketEntity market;
  int productCount;
  OrderState statue;
  String statueTranslate;
  String orderDatetime;

  OrderEntity({
    required this.id,
    required this.market,
    required this.orderDatetime,
    required this.productCount,
    required this.statue,
    required this.statueTranslate,
  });

  static final fakeData = OrderEntity(
    id: 0,
    market: MarketEntity(id: 0, name: "name", logo: "logo"),
    orderDatetime: "orderDatetime",
    productCount: 0,
    statue: OrderState.canceled,
    statueTranslate: "statueTranslate",
  );
}
