import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductPriceAndQuantity extends GetView<ProductDetailsController> {
  const ProductPriceAndQuantity({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        tag: Get.arguments.toString(),
        builder: (controller) {
          return Obx(
            () => Column(
              children: [
                if (controller.loadingGetProduct) ...[
                  Skeletonizer(
                    enabled: true,
                    effect: const ShimmerEffect(),
                    child: Row(
                      children: [
                        const AppIcon(
                          icon: IconsAssets.coins,
                          width: 20,
                          height: 20,
                        ),
                        10.horizontalSpace(),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            num.parse("764850").formatCurrency(context),
                            style: Get.textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeightManger.semiBold,
                              fontSize: AppSize.s15(context),
                            ),
                          ),
                        ),
                        10.horizontalSpace(),
                      ],
                    ),
                  ),
                  13.verticalSpace(),
                ] else ...[
                  Row(
                    children: [
                      const AppIcon(
                        icon: IconsAssets.coins,
                        width: 20,
                        height: 20,
                      ),
                      10.horizontalSpace(),
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          controller.getProductPrice() == 0
                              ? AppStrings.priceUponSelection
                              : controller
                                  .getProductPrice()
                                  .formatCurrency(context),
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeightManger.semiBold,
                            fontSize: AppSize.s15(context),
                          ),
                        ),
                      ),
                      10.horizontalSpace(),
                      InkWell(
                        onTap: controller.onIncreaseQuantity,
                        child: Container(
                          width: 27,
                          height: 27,
                          decoration: const BoxDecoration(
                            color: ColorManager.primary,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: ColorManager.white,
                          ),
                        ),
                      ),
                      8.horizontalSpace(),
                      Text(
                        "${controller.quantity}",
                        style: Get.textTheme.titleMedium!.copyWith(
                          fontSize: AppSize.s15(context),
                        ),
                      ),
                      8.horizontalSpace(),
                      InkWell(
                        onTap: controller.onDecreaseQuantity,
                        child: Container(
                          width: 27,
                          height: 27,
                          decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.primary),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  13.verticalSpace(),
                ],
              ],
            ),
          );
        });
  }
}
