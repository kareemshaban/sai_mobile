import 'package:json_annotation/json_annotation.dart';
part 'product_option_model.g.dart';

@JsonSerializable()
class ProductOptionModel {
  int? id;
  String? name;
  String? type;
  num? price;
  List<ProductOptionValuesModel>? values;

  ProductOptionModel({
    this.id,
    this.name,
    this.type,
    this.price,
    this.values,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionModelToJson(this);
}

@JsonSerializable()
class ProductOptionValuesModel {
  int? id;
  String? name;

  ProductOptionValuesModel({
    this.id,
    this.name,
  });

  factory ProductOptionValuesModel.fromJson(Map<String, dynamic> json) =>
      _$ProductOptionValuesModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductOptionValuesModelToJson(this);
}
