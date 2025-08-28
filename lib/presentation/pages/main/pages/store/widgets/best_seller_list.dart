import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_loading/product_loading_item.dart';

import '../../../../../widgets/product_item.dart';

class BestSellerList extends GetView<StoreController> {
  const BestSellerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingHomeData
          ? Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppStrings.bestSeller,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s25(context),
                    ),
                  ),
                ),
                11.verticalSpace(),
                SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => const ProductLoadingItem(),
                    separatorBuilder: (context, index) => 9.horizontalSpace(),
                    itemCount: 5,
                  ),
                ),
              ],
            )
          : Column(
              children: [
                if (controller.homeData.products.isNotEmpty) ...[
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      AppStrings.bestSeller,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s25(context),
                      ),
                    ),
                  ),
                  11.verticalSpace(),
                  SizedBox(
                    height: 250,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Obx(
                          () {
                            final product = controller.homeData.products[index];
                            return ProductItem(
                              product: product,
                              isFavorite: product.isMyFavorite == 1,
                              onTapFavorite: () async {
                                await controller.onTapFavorite(index);
                              },
                            );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => 9.horizontalSpace(),
                      itemCount: controller.homeData.products.length,
                    ),
                  ),
                ],
              ],
            ),
    );
  }
}
