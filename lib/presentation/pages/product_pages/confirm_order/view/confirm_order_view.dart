import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/getx/confirm_order_controller.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/widgets/bill_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/widgets/confirm_order_product_widget.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/widgets/delivery_method_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class ConfirmOrderView extends GetView<ConfirmOrderController> {
  const ConfirmOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.confirmOrder),
        leading: const AppBackButton(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => ConfirmOrderProductWidget(
                  model: controller.cartController.products[index],
                ),
                separatorBuilder: (context, index) => 10.verticalSpace(),
                itemCount: controller.cartController.products.length,
              ),
              const Divider(height: 40),
              const DeliveryMethodWidget(),
              AppFormFiled(
                lineCount: 5,
                controller: controller.noteController,
                label: AppStrings.addANote,
                labelOnBorder: true,
                filledColor: ColorManager.transparent,
              ),
              const Divider(height: 40),
              AppFormFiled(
                borderRadius: 100,
                readOnly: controller.coupon.discountId != 0,
                borderColor: ColorManager.black.withOpacity(.4),
                hint: AppStrings.discountCode,
                controller: controller.couponController,
                onSubmit: (value) => controller.applyCoupon(),
                suffixIcon: controller.loadingCoupon
                    ? const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: AppLoader(),
                      )
                    : AppButton(
                        title: controller.coupon.discountId != 0
                            ? AppStrings.delete
                            : AppStrings.activation,
                        backgroundColor: controller.coupon.discountId != 0
                            ? ColorManager.red
                            : null,
                        textStyle: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s15(context),
                          fontWeight: FontWeight.w600,
                        ),
                        onTap: controller.applyCoupon,
                        margin: const EdgeInsets.all(10),
                        radius: 100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                      ),
              ),
              35.verticalSpace(),
              BillWidget(
                total: controller.getProductPrice().formatCurrency(context),
                discount: controller.coupon.discount.toString(),
                finalTotal: controller.getFinalPrice().formatCurrency(context),
                deliveryValue: controller.deliveryValue == "to_address"
                    ? controller.addressCost.formatCurrency(context)
                    : null,
              ),
              if (controller.loadingAddOrder)
                const Center(child: AppLoader())
              else
                AppButton(
                  title: AppStrings.order,
                  onTap: controller.addOrder,
                  width: 1.w(context),
                  radius: 10,
                  textStyle: Get.textTheme.bodyLarge!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
