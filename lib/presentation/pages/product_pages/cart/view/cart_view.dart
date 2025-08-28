import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:lottie/lottie.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/getx/cart_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/widgets/cart_button.dart';
import 'package:new_sai/presentation/pages/product_pages/cart/widgets/cart_product_item.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: const AppBackButton(),
          leadingWidth: 60,
          title: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${AppStrings.cart} ",
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
                if (controller.products.isNotEmpty)
                  TextSpan(
                    text:
                        "(${controller.products.length} ${AppStrings.products2})",
                    style: Get.textTheme.labelSmall!.copyWith(
                      fontSize: AppSize.s20(context),
                    ),
                  ),
              ],
            ),
          ),
        ),
        body: controller.products.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(LottieAssets.emptyCart),
                      20.verticalSpace(),
                      Text(
                        AppStrings.cartIsEmptyAddProductNow,
                        style: Get.textTheme.titleLarge!,
                      ),
                    ],
                  ),
                ),
              )
            : ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                itemBuilder: (context, index) => Obx(
                  () => CartProductItem(
                    model: controller.products[index],
                    onIncreaceQuantity: () =>
                        controller.onIncreaceProduct(index),
                    onDecreaceQuantity: () =>
                        controller.onDecreaceProduct(index),
                    onDeleteProduct: () => controller.onDeleteProduct(index),
                  ),
                ),
                separatorBuilder: (context, index) => 9.verticalSpace(),
                itemCount: controller.products.length,
              ),
        bottomNavigationBar: const CartButton(),
      ),
    );
  }
}
