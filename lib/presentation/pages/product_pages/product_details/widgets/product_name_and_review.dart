import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductNameAndReview extends GetView<ProductDetailsController> {
  const ProductNameAndReview({super.key});

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
                    effect: const ShimmerEffect(),
                    enabled: true,
                    child: Row(
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Text(
                            "آيفون 15 برو ماكس إصدار 2",
                            style: Get.textTheme.titleLarge!.copyWith(
                              fontSize: AppSize.s17(context),
                              fontWeight: FontWeightManger.semiBold,
                            ),
                          ),
                        ),
                        8.horizontalSpace(),
                        const AppIcon(
                          icon: IconsAssets.star,
                          width: 15,
                          height: 15,
                        ),
                        2.horizontalSpace(),
                        Text(
                          "4.8",
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s15(context),
                          ),
                        ),
                        2.horizontalSpace(),
                        Text(
                          '(30+)',
                          style: Get.textTheme.headlineSmall!.copyWith(
                            fontWeight: FontWeightManger.light,
                            fontSize: AppSize.s14(context),
                          ),
                        )
                      ],
                    ),
                  ),
                  14.verticalSpace(),
                ] else ...[
                  Row(
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: Text(
                          controller.product.name,
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSize.s17(context),
                            fontWeight: FontWeightManger.semiBold,
                          ),
                        ),
                      ),
                      8.horizontalSpace(),
                      const AppIcon(
                        icon: IconsAssets.star,
                        width: 15,
                        height: 15,
                      ),
                      2.horizontalSpace(),
                      Text(
                        controller.product.reviewVal.toString(),
                        style: Get.textTheme.titleSmall!.copyWith(
                          fontSize: AppSize.s15(context),
                        ),
                      ),
                      2.horizontalSpace(),
                      Text(
                        '(${controller.product.reviewsCount}+)',
                        style: Get.textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeightManger.light,
                          fontSize: AppSize.s14(context),
                        ),
                      )
                    ],
                  ),
                  14.verticalSpace(),
                ],
              ],
            ),
          );
        });
  }
}
