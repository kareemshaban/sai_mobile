import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/wallet_pages/payment_method/getx/payment_method_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class PaymentMethodView extends GetView<PaymentMethodController> {
  const PaymentMethodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.paymentMethod),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.chooseYourWithdrawalMethod,
              style: Get.textTheme.titleMedium!.copyWith(
                fontSize: AppSize.s15(context),
              ),
            ),
            15.verticalSpace(),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.addBankAccountRoute),
              child: Container(
                width: 1.w(context),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.white,
                ),
                child: Row(
                  children: [
                    const AppIcon(icon: IconsAssets.bank),
                    8.horizontalSpace(),
                    Text(
                      AppStrings.bankTransfer,
                      style: Get.textTheme.titleSmall!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorManager.iconGreyColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
            15.verticalSpace(),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.addPaypalAccountRoute),
              child: Container(
                width: 1.w(context),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorManager.white,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.paypal,
                      width: 25,
                      height: 25,
                    ),
                    8.horizontalSpace(),
                    Text(
                      "PayPal",
                      style: Get.textTheme.titleSmall!.copyWith(
                        fontSize: AppSize.s15(context),
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: ColorManager.iconGreyColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
