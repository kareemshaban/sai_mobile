import 'package:json_annotation/json_annotation.dart';
part 'product_quantity_options_model.g.dart';

@JsonSerializable()
class ProductQuantityOptionsModel {
  @JsonKey(name: "quantity_option_id")
  int? quantityOptionId;
  @JsonKey(name: "option_value_id")
  List<ProductQuantityOptionValuesModel>? optionValueId;
  num? qnt;
  @JsonKey(name: "buy_price")
  num? buyPrice;
  @JsonKey(name: "min_order_qnt")
  num? minOrderQnt;
  @JsonKey(name: "max_order_qnt")
  num? maxOrderQnt;

  ProductQuantityOptionsModel({
    this.quantityOptionId,
    this.optionValueId,
    this.qnt,
    this.buyPrice,
    this.minOrderQnt,
    this.maxOrderQnt,
  });

  factory ProductQuantityOptionsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductQuantityOptionsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductQuantityOptionsModelToJson(this);
}

@JsonSerializable()
class ProductQuantityOptionValuesModel {
  int? option;
  int? value;

  ProductQuantityOptionValuesModel({
    this.option,
    this.value,
  });

  factory ProductQuantityOptionValuesModel.fromJson(
          Map<String, dynamic> json) =>
      _$ProductQuantityOptionValuesModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ProductQuantityOptionValuesModelToJson(this);
}
