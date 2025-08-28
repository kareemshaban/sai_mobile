import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductStoreDetails extends GetView<ProductDetailsController> {
  const ProductStoreDetails({super.key});

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
                        const AppImage(
                          image: Constants.userErrorWidget,
                          width: 60,
                          height: 60,
                          radius: 10,
                        ),
                        10.horizontalSpace(),
                        Flexible(
                          child: Text(
                            "متجر ساي",
                            style: Get.textTheme.titleLarge!.copyWith(
                              fontSize: AppSize.s16(context),
                              fontWeight: FontWeightManger.semiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  7.verticalSpace(),
                ] else ...[
                  Row(
                    children: [
                      AppImage(
                        image: controller.product.market.logo,
                        width: 60,
                        height: 60,
                        radius: 10,
                      ),
                      10.horizontalSpace(),
                      Flexible(
                        child: Text(
                          controller.product.market.name,
                          style: Get.textTheme.titleLarge!.copyWith(
                            fontSize: AppSize.s16(context),
                            fontWeight: FontWeightManger.semiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  7.verticalSpace(),
                ],
              ],
            ),
          );
        });
  }
}
