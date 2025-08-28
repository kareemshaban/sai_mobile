import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class OrderBottomSheetButton extends GetView<ProductDetailsController> {
  const OrderBottomSheetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
        tag: Get.arguments.toString(),
        builder: (controller) {
          return Obx(
            () => controller.loadingGetProduct
                ? const SizedBox()
                : Container(
                    width: 1.w(context),
                    color: ColorManager.white,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: AppButton(
                            title: AppStrings.orderNow,
                            radius: 10,
                            onTap: controller.addToCart,
                            textStyle: Get.textTheme.bodyLarge!.copyWith(
                              fontSize: AppSize.s16(context),
                            ),
                          ),
                        ),
                        10.horizontalSpace(),
                        AppButton(
                          title: '',
                          radius: 10,
                          onTap: controller.onTapFavorite,
                          widget: Icon(
                            controller.product.isMyFavorite == 1
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: controller.product.isMyFavorite == 1
                                ? ColorManager.red
                                : ColorManager.white,
                          ),
                        )
                      ],
                    ),
                  ),
          );
        });
  }
}
