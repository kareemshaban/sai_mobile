import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loading/product_loading_item.dart';
import 'package:new_sai/presentation/widgets/product_item.dart';

class SimilarProductsList extends GetView<ProductDetailsController> {
  const SimilarProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        tag: Get.arguments.toString(),
        builder: (controller) {
          return Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.loadingGetProduct) ...[
                  Text(
                    AppStrings.similarProducts,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s15(context),
                    ),
                  ),
                  15.verticalSpace(),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.67,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return const ProductLoadingItem();
                    },
                    itemCount: 4,
                  ),
                ] else ...[
                  if (controller.similarProduct.isNotEmpty) ...[
                    Text(
                      AppStrings.similarProducts,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ),
                    15.verticalSpace(),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.623,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Obx(
                          () => ProductItem(
                            product: controller.similarProduct[index],
                            isForFavorite: true,
                            onTapFavorite: () =>
                                controller.onTapFavoriteOnList(index),
                            isFavorite:
                                controller.similarProduct[index].isMyFavorite ==
                                    1,
                          ),
                        );
                      },
                      itemCount: controller.similarProduct.length,
                    ),
                  ],
                ],
              ],
            ),
          );
        });
  }
}
