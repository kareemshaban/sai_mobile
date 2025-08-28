import 'package:json_annotation/json_annotation.dart';
part 'add_order_params.g.dart';

@JsonSerializable()
class AddOrderParams {
  @JsonKey(name: "delivery_type", includeIfNull: false)
  String? deliveryType;
  @JsonKey(name: "address_id", includeIfNull: false)
  int? addressId;
  @JsonKey(name: "part_price", includeIfNull: false)
  num? partPrice;
  @JsonKey(name: "total_price", includeIfNull: false)
  num? totalPrice;
  @JsonKey(includeIfNull: false)
  String? note;
  @JsonKey(includeIfNull: false)
  List<AddOrderProductParams>? products;
  @JsonKey(name: "discount_id", includeIfNull: false)
  int? discountId;

  AddOrderParams({
    this.deliveryType,
    this.addressId,
    this.partPrice,
    this.totalPrice,
    this.note,
    this.products,
    this.discountId,
  });

  factory AddOrderParams.fromJson(Map<String, dynamic> json) =>
      _$AddOrderParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddOrderParamsToJson(this);
}

@JsonSerializable()
class AddOrderProductParams {
  @JsonKey(name: "product_id", includeIfNull: false)
  int? productId;
  @JsonKey(name: "total_price", includeIfNull: false)
  num? totalPrice;
  @JsonKey(includeIfNull: false)
  int? quantity;
  @JsonKey(name: "option_check", includeIfNull: false)
  List<int>? optionCheck;
  @JsonKey(name: "quantity_option_id", includeIfNull: false)
  int? quantityOptionId;

  AddOrderProductParams({
    this.productId,
    this.totalPrice,
    this.quantity,
    this.optionCheck,
    this.quantityOptionId,
  });

  factory AddOrderProductParams.fromJson(Map<String, dynamic> json) =>
      _$AddOrderProductParamsFromJson(json);

  Map<String, dynamic> toJson() => _$AddOrderProductParamsToJson(this);
}
