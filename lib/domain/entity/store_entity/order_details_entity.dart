import 'address_entity.dart';
import 'market_entity.dart';
import 'product_entity.dart';

class OrderDetailsEntity {
  int id;
  MarketEntity market;
  String statue;
  String statueTranslate;
  String orderDatetime;
  num productCount;
  List<ProductEntity> products;
  String deliveryType;
  String deliveryTypeTranslate;
  AddressEntity address;
  num partCost;
  num discountPercent;
  num discountCost;
  num deliveryCost;
  num totalCost;

  OrderDetailsEntity({
    required this.id,
    required this.products,
    required this.deliveryType,
    required this.market,
    required this.deliveryCost,
    required this.deliveryTypeTranslate,
    required this.discountCost,
    required this.discountPercent,
    required this.orderDatetime,
    required this.partCost,
    required this.productCount,
    required this.statue,
    required this.statueTranslate,
    required this.totalCost,
    required this.address,
  });
}
