import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/store_model/banner_model.dart';
import 'package:new_sai/data/model/store_model/category_model.dart';
import 'package:new_sai/data/model/store_model/product_model.dart';
part 'home_model.g.dart';

@JsonSerializable()
class HomeModel {
  List<BannerModel>? banners;
  List<CategoryModel>? categories;
  List<ProductModel>? products;

  HomeModel({
    this.categories,
    this.products,
    this.banners,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) =>
      _$HomeModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}
