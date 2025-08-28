import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/getx/wallet_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class WalletTabBar extends GetView<WalletController> {
  const WalletTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: TabBar(
        padding: const EdgeInsets.symmetric(horizontal: 100),
        controller: controller.tabController,
        tabs: [
          // Tab(
          //   text: AppStrings.rewards,
          // ),
          Tab(
            text: AppStrings.coins,
          ),
        ],
        labelStyle: Get.textTheme.titleMedium!.copyWith(
          fontSize: AppSize.s18(context),
        ),
        unselectedLabelStyle: Get.textTheme.headlineMedium!.copyWith(
          fontSize: AppSize.s18(context),
        ),
        indicatorColor: ColorManager.black.withOpacity(0.5),
      ),
    );
  }
}
