import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/store_entity/category_entity.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'category_search_item.dart';

class CategorySearchCategoryList extends GetView<CategorySearchController> {
  const CategorySearchCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingGetFilter
          ? SizedBox(
              height: 33,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Skeletonizer(
                  enabled: true,
                  containersColor: ColorManager.white,
                  effect: const ShimmerEffect(),
                  child: CategorySearchItem(
                    model: CategoryEntity.fakeData,
                  ),
                ),
                separatorBuilder: (context, index) => 8.horizontalSpace(),
                itemCount: 10,
              ),
            )
          : SizedBox(
              height: 33,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Obx(
                  () => CategorySearchItem(
                    model: controller.categories[index],
                    isSelected: controller.category.id ==
                        controller.categories[index].id,
                    onTap: () {
                      controller.searchController.clear();
                      controller.category = controller.categories[index];
                      controller.searchProduct();
                    },
                  ),
                ),
                separatorBuilder: (context, index) => 8.horizontalSpace(),
                itemCount: controller.categories.length,
              ),
            ),
    ).toSliver();
  }
}
