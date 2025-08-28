import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/domain/entity/store_entity/product_option_entity.dart';

class ProductFilterEntity {
  List<CategoryEntity> categories;
  List<ProductOptionEntity> options;

  ProductFilterEntity({
    required this.options,
    required this.categories,
  });
}
