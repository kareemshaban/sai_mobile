import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_controller.dart';
import 'package:new_sai/presentation/widgets/app_loading/product_loading_item.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/product_item.dart';

class CategorySearchProductList extends GetView<CategorySearchController> {
  const CategorySearchProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingSearch
          ? SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
              sliver: SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: .65,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) => const ProductLoadingItem(),
                itemCount: 10,
              ),
            )
          : controller.products.isEmpty
              ? const SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyDataWidget(),
                )
              : SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
                  sliver: SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .65,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => ProductItem(
                      product: controller.products[index],
                      isForFavorite: true,
                      isFavorite: controller.products[index].isMyFavorite == 1,
                      onTapFavorite: () {
                        controller.onTapFavoriteOnList(index);
                      },
                    ),
                    itemCount: controller.products.length,
                  ),
                ),
    );
  }
}
