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
      aspectRatio: 1.8,
      child: Container(

        width: 1.w(context),
        height: 250,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/Gold-bag.png'))  ,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.coins,
              style: Get.textTheme.bodyMedium!.copyWith(
                fontSize: AppSize.s30(context),
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
                        fontSize: AppSize.s30(context),
                      ),
                    ),
                    const WidgetSpan(
                      child: AppIcon(
                        icon: IconsAssets.coins,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              );
            }),
            const Spacer(),
            Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration( color: ColorManager.black.withAlpha(100), borderRadius: BorderRadius.all(Radius.circular(10.0))),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.chargeWalletRoute);
                },
                child: Text(
                  AppStrings.recharge,
                  style: Get.textTheme.bodyMedium!.copyWith(
                    fontSize: AppSize.s18(context),
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
