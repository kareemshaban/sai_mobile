import 'package:new_sai/data/mapper/store_mapper.dart';
import 'package:new_sai/data/model/store_model/product_model.dart';
import 'package:new_sai/domain/entity/app_entity/images_entity.dart';
import 'package:new_sai/domain/entity/app_entity/pagination_entity.dart';
import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/domain/entity/store_entity/market_entity.dart';

import 'product_option_entity.dart';
import 'product_quantity_options_entity.dart';

class ProductPaginationEntity {
  List<ProductEntity> data;
  PaginationEntity pagination;

  ProductPaginationEntity({
    required this.data,
    required this.pagination,
  });
}

class ProductDetailsEntity {
  ProductEntity product;
  List<ProductEntity> relatedProducts;

  ProductDetailsEntity({
    required this.product,
    required this.relatedProducts,
  });
}

class ProductEntity {
  int id;
  String name;
  MarketEntity market;
  CategoryEntity category;
  String description;
  num quantity;
  num minOrderQnt;
  num maxOrderQnt;
  String code;
  num buyPrice;
  num offerPrice;
  num isMyFavorite;
  num isRateByMe;
  String image;
  num reviewVal;
  num hasOptions;
  num reviewsCount;
  num countView;
  List<ImagesEntity> images;
  List<ProductOptionEntity> options;
  List<ProductQuantityOptionEntity> quantityOptions;
  num price;

  ProductEntity({
    required this.name,
    required this.id,
    required this.image,
    required this.buyPrice,
    required this.category,
    required this.hasOptions,
    required this.isMyFavorite,
    required this.isRateByMe,
    required this.offerPrice,
    required this.reviewVal,
    required this.reviewsCount,
    required this.code,
    required this.market,
    required this.countView,
    required this.description,
    required this.images,
    required this.maxOrderQnt,
    required this.minOrderQnt,
    required this.options,
    required this.quantity,
    required this.quantityOptions,
    required this.price,
  });

  static final fakeData = ProductModel().toDomain();
}
