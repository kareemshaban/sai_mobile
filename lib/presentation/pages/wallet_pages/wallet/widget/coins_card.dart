import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/getx/charge_wallet_controller.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/getx/wallet_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CoinsCard extends GetView<WalletController> {
  CoinsCard({super.key});
  // final chargeWalletController = Get.find<ChargeWalletController>();
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.95,
      child: Container(
        width: 1.w(context),
        height: 194,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: ColorManager.walletGradientColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.coins,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            10.verticalSpace(),
            Obx(() {
              if (controller.isLoading) return Container();

              return RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: controller.unitEntity?.userGold
                              .formatCurrency(context) ??
                          "",
                      //  '${controller.appController.user.goldValue} ',
                      style: Get.textTheme.bodyMedium!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                    ),
                    const WidgetSpan(
                      child: AppIcon(
                        icon: IconsAssets.coins,
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Spacer(),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.chargeWalletRoute);
              },
              child: Center(
                child: Text(
                  AppStrings.recharge,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
