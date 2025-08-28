import 'package:json_annotation/json_annotation.dart';
import 'package:new_sai/data/model/app_model/images_model.dart';
import 'package:new_sai/data/model/app_model/pagination_model.dart';
import 'package:new_sai/data/model/store_model/category_model.dart';
import 'package:new_sai/data/model/store_model/market_model.dart';

import 'product_option_model.dart';
import 'product_quantity_options_model.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductPaginationModel {
  List<ProductModel>? data;
  PaginationModel? pagination;

  ProductPaginationModel({
    this.data,
    this.pagination,
  });

  factory ProductPaginationModel.fromJson(Map<String, dynamic> json) =>
      _$ProductPaginationModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPaginationModelToJson(this);
}

@JsonSerializable()
class ProductDetailsModel {
  ProductModel? product;
  @JsonKey(name: "related_products")
  List<ProductModel>? relatedProducts;

  ProductDetailsModel({
    this.product,
    this.relatedProducts,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsModelToJson(this);
}

@JsonSerializable()
class ProductModel {
  int? id;
  String? name;
  MarketModel? market;
  CategoryModel? category;
  String? description;
  num? quantity;
  @JsonKey(name: "min_order_qnt")
  num? minOrderQnt;
  @JsonKey(name: "max_order_qnt")
  num? maxOrderQnt;
  String? code;
  @JsonKey(name: "buy_price")
  num? buyPrice;
  @JsonKey(name: "offer_price")
  num? offerPrice;
  @JsonKey(name: "is_my_favorite")
  num? isMyFavorite;
  @JsonKey(name: "is_rate_by_me")
  num? isRateByMe;
  String? image;
  @JsonKey(name: "review_val")
  num? reviewVal;
  @JsonKey(name: "has_options")
  num? hasOptions;
  @JsonKey(name: "reviews_count")
  num? reviewsCount;
  @JsonKey(name: "count_view")
  num? countView;
  List<ImagesModel>? images;
  List<ProductOptionModel>? options;
  @JsonKey(name: "quantity_options")
  List<ProductQuantityOptionsModel>? quantityOptions;
  num? price;

  ProductModel({
    this.name,
    this.id,
    this.image,
    this.buyPrice,
    this.category,
    this.hasOptions,
    this.isMyFavorite,
    this.isRateByMe,
    this.offerPrice,
    this.reviewVal,
    this.reviewsCount,
    this.code,
    this.market,
    this.countView,
    this.description,
    this.images,
    this.maxOrderQnt,
    this.minOrderQnt,
    this.options,
    this.quantity,
    this.quantityOptions,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
