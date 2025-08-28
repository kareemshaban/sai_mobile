import 'package:json_annotation/json_annotation.dart';
part 'product_search_params.g.dart';

@JsonSerializable()
class ProductSearchParams {
  @JsonKey(
    includeFromJson: false,
    includeToJson: false,
  )
  int? page;
  @JsonKey(name: "term", includeIfNull: false)
  String? search;
  @JsonKey(name: "sort_type", includeIfNull: false)
  String? sortType;
  @JsonKey(name: "from_price", includeIfNull: false)
  num? fromPrice;
  @JsonKey(name: "to_price", includeIfNull: false)
  num? toPrice;
  @JsonKey(name: "category_id", includeIfNull: false)
  num? categoryId;
  @JsonKey(name: "options", includeIfNull: false)
  List<ProductSearchOptionParams>? options;

  ProductSearchParams({
    this.options,
    this.search,
    this.categoryId,
    this.fromPrice,
    this.page,
    this.sortType,
    this.toPrice,
  });

  factory ProductSearchParams.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchParamsToJson(this);
}

@JsonSerializable()
class ProductSearchOptionParams {
  @JsonKey(includeIfNull: false)
  int? id;
  @JsonKey(includeIfNull: false)
  int? value;

  ProductSearchOptionParams({
    this.id,
    this.value,
  });

  factory ProductSearchOptionParams.fromJson(Map<String, dynamic> json) =>
      _$ProductSearchOptionParamsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSearchOptionParamsToJson(this);
}
