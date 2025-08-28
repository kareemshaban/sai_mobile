import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/empty_data_widget.dart';
import 'package:new_sai/presentation/widgets/product_item.dart';
import 'package:new_sai/presentation/pages/product_pages/favorite/getx/favorite_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_loading/product_loading_item.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: Obx(
          () => RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.favorite,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
                TextSpan(
                  text:
                      " (${controller.products.length} ${AppStrings.products2})",
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s20(context),
                    color: ColorManager.iconGreyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: RefreshIndicator(
            onRefresh: () => controller.getMyFavorite(),
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                if (controller.loading)
                  SliverGrid.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 17,
                      mainAxisSpacing: 10,
                      childAspectRatio: .623,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return const ProductLoadingItem(isForFavorite: true);
                    },
                    itemCount: 4,
                  )
                else
                  controller.products.isEmpty
                      ? const SliverFillRemaining(
                          hasScrollBody: false,
                          child: EmptyDataWidget(),
                        )
                      : SliverGrid.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 17,
                            mainAxisSpacing: 10,
                            childAspectRatio: .623,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(() {
                              final product = controller.products[index];
                              return ProductItem(
                                product: product,
                                isForFavorite: true,
                                isFavorite: product.isMyFavorite == 1,
                                onTapFavorite: () =>
                                    controller.onTapFavorite(index),
                              );
                            });
                          },
                          itemCount: controller.products.length,
                        ),
                if (controller.loadingPagination)
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: const Center(
                      child: AppLoader(),
                    ).toSliver(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
