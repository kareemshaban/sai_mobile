import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDescription extends GetView<ProductDetailsController> {
  const ProductDescription({super.key});

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
                    AppStrings.description,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s17(context),
                    ),
                  ),
                  5.verticalSpace(),
                  Skeletonizer(
                    effect: const ShimmerEffect(),
                    enabled: true,
                    child: Text(
                      "تيتانيوم أبيض واجهة درع السيراميك، سطح خلفي من الزجاج المركب غير اللامع، ثلاث كاميرات 256 جيجا يحتوي على 2Sim شاشة ريتنا سوبر XDR تغطي الواجهة بالكامل مقاس 6.7 إنش (قطرياً)، وضوح 2796 × 1290 بكسل بكثافة 460 بكسل لكل إنش تكنولوجيا ProMotion مع معدلات تحديث متكيف تصل إلى 120Hz تكنولوجيا انسجام اللون‏ مجموعة ألوان كبيرة (P3)...",
                      style: Get.textTheme.headlineMedium!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ),
                  ),
                  15.verticalSpace(),
                ] else ...[
                  if (controller.product.description.isNotEmpty) ...[
                    Text(
                      AppStrings.description,
                      style: Get.textTheme.titleMedium!.copyWith(
                        fontSize: AppSize.s17(context),
                      ),
                    ),
                    5.verticalSpace(),
                    Text(
                      controller.product.description,
                      style: Get.textTheme.headlineMedium!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ),
                    15.verticalSpace(),
                  ],
                ],
              ],
            ),
          );
        });
  }
}
