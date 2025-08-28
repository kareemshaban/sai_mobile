import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/store_model/category_model.dart';
import 'package:new_sai/data/model/store_model/product_option_model.dart';
part 'product_filter_model.g.dart';

@JsonSerializable()
class ProductFilterModel {
  List<CategoryModel>? categories;
  List<ProductOptionModel>? options;

  ProductFilterModel({
    this.options,
    this.categories,
  });

  factory ProductFilterModel.fromJson(Map<String, dynamic> json) =>
      _$ProductFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductFilterModelToJson(this);
}
