import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/getx/wallet_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class BalanceCard extends GetView<WalletController> {
  const BalanceCard({super.key});

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
              AppStrings.balance,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            10.verticalSpace(),
            Obx(
              () => Text(
                '${controller.appController.user.goldValue / 100} \$',
                style: Get.textTheme.bodyLarge!.copyWith(
                  fontSize: AppSize.s24(context),
                ),
              ),
            ),
            10.verticalSpace(),
            Row(
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '150 ',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                      const WidgetSpan(
                        child: AppIcon(
                          icon: IconsAssets.coins,
                        ),
                      ),
                      TextSpan(
                        text: ' = 1 ${AppStrings.sar}',
                        style: Get.textTheme.bodyMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                    ],
                  ),
                ),
                5.horizontalSpace(),
                const AppIcon(
                  icon: IconsAssets.sar,
                  width: 20,
                  height: 20,
                  color: ColorManager.white,
                )
              ],
            ),
            const Spacer(),
            Center(
              child: InkWell(
                onTap: () => Get.toNamed(AppRoutes.cashWithdrawalRoute),
                child: Text(
                  AppStrings.cashWithDrawal,
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
