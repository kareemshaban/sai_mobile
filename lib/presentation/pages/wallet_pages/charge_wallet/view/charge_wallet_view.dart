import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/getx/charge_wallet_controller.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/widgets/carousell_widget.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/widgets/coin_price_card.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class ChargeWalletView extends GetView<ChargeWalletController> {
  const ChargeWalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.chargeWallet),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Obx(() {
          return controller.isLoading
              ? const Center(
                  child: AppLoader(),
                )
              : CustomScrollView(
                  slivers: [
                    
                    30.verticalSpace().toSliver(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppStrings.balance}:",
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsetsDirectional.only(end: 10),
                              child: const AppIcon(
                                icon: IconsAssets.coins,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            // Text('asdads',style: TextStyle(color: Colors.amber),),
                            Text(
                              controller.unitEntity.userGold
                                  .formatCurrency(context),
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeightManger.semiBold,
                                fontSize: AppSize.s15(context),
                              ),
                            ),
                          ],
                        )
                      ],
                    ).toSliver(),
                    20.verticalSpace().toSliver(),
                    CarousellWidget(
                      bannerEntity: controller.unitEntity.banner,
                    ).toSliver(),
                    20.verticalSpace().toSliver(),
                    SliverList.builder(
                      itemCount: controller.unitEntity.charginUnits.length,
                      itemBuilder: (context, index) => CoinPriceCard(
                        unit: controller.unitEntity.charginUnits[index],
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }
}
