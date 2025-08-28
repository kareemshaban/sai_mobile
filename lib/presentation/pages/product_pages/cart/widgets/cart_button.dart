import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CartButton extends GetView<CartController> {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.products.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 20,
              ),
              child: InkWell(
                onTap: () => Get.toNamed(AppRoutes.confirmOrderRoute),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: ColorManager.primary,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${controller.products.length} ${AppStrings.products2}",
                            style: Get.textTheme.bodySmall!.copyWith(
                              fontSize: AppSize.s10(context),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                controller
                                    .getAllProductPrice()
                                    .formatCurrency(context),
                                style: Get.textTheme.bodyMedium!.copyWith(
                                  fontSize: AppSize.s12(context),
                                ),
                              ),
                              2.horizontalSpace(),
                              const AppIcon(
                                icon: IconsAssets.coins,
                                width: 12,
                                height: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        AppStrings.completeThePurchase,
                        style: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s20(context),
                          fontWeight: FontWeightManger.semiBold,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: ColorManager.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
