import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/store_model/market_model.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  int? id;
  MarketModel? market;
  @JsonKey(name: "product_count")
  int? productCount;
  String? statue;
  @JsonKey(name: "statue_translate")
  String? statueTranslate;
  @JsonKey(name: "order_datetime")
  String? orderDatetime;

  OrderModel({
    this.id,
    this.market,
    this.orderDatetime,
    this.productCount,
    this.statue,
    this.statueTranslate,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
