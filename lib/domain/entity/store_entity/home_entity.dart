import 'banner_entity.dart';
import 'category_entity.dart';
import 'product_entity.dart';

class HomeEntity {
  List<BannerEntity> banners;
  List<CategoryEntity> categories;
  List<ProductEntity> products;

  HomeEntity({
    required this.categories,
    required this.products,
    required this.banners,
  });
}
