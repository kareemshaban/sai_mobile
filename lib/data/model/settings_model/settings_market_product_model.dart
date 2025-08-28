import 'package:json_annotation/json_annotation.dart';
part 'settings_market_product_model.g.dart';

@JsonSerializable()
class SettingsMarketProductModel {
  int? id;
  String? name;
  @JsonKey(name: "gold_price")
  num? goldPrice;
  @JsonKey(name: "expiration_date")
  String? expirationDate;
  String? image;
  String? category;
  @JsonKey(name: "product_id")
  String? productId;
  @JsonKey(name: "is_buy")
  bool? isBuy;
  @JsonKey(name: "is_selected")
  bool? isSelected;

  SettingsMarketProductModel({
    this.id,
    this.name,
    this.image,
    this.category,
    this.isSelected,
    this.expirationDate,
    this.goldPrice,
    this.isBuy,
    this.productId,
  });

  factory SettingsMarketProductModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsMarketProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsMarketProductModelToJson(this);
}
