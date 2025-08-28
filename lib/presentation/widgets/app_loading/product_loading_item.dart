import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/store_entity/product_entity.dart';
import 'package:new_sai/presentation/widgets/product_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductLoadingItem extends StatelessWidget {
  final bool isForFavorite;
  const ProductLoadingItem({
    super.key,
    this.isForFavorite = false,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(),
      child: ProductItem(
        isLoading: true,
        isForFavorite: isForFavorite,
        product: ProductEntity.fakeData,
      ),
    );
  }
}
