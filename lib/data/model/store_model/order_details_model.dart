import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/store_model/market_model.dart';
import 'package:new_sai/data/model/store_model/product_model.dart';

import 'address_model.dart';
part 'order_details_model.g.dart';

@JsonSerializable()
class OrderDetailsModel {
  int? id;
  MarketModel? market;
  String? statue;
  @JsonKey(name: "statue_translate")
  String? statueTranslate;
  @JsonKey(name: "order_datetime")
  String? orderDatetime;
  @JsonKey(name: "product_count")
  num? productCount;
  List<ProductModel>? products;
  @JsonKey(name: "delivery_type")
  String? deliveryType;
  @JsonKey(name: "delivery_type_translate")
  String? deliveryTypeTranslate;
  AddressModel? address;
  @JsonKey(name: "part_cost")
  num? partCost;
  @JsonKey(name: "discount_percent")
  num? discountPercent;
  @JsonKey(name: "discount_cost")
  num? discountCost;
  @JsonKey(name: "delivery_cost")
  num? deliveryCost;
  @JsonKey(name: "total_cost")
  num? totalCost;

  OrderDetailsModel({
    this.id,
    this.products,
    this.deliveryType,
    this.market,
    this.deliveryCost,
    this.deliveryTypeTranslate,
    this.discountCost,
    this.discountPercent,
    this.orderDatetime,
    this.partCost,
    this.productCount,
    this.statue,
    this.statueTranslate,
    this.totalCost,
    this.address,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);
}
