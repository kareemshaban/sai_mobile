import 'package:flutter/material.dart';
import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/presentation/pages/main/pages/store/widgets/category_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoryLoadingItem extends StatelessWidget {
  const CategoryLoadingItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CategoryItem(
        category: CategoryEntity.fakeData,
      ),
    );
  }
}
