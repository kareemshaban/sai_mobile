import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/getx/cash_withdrawal_controller.dart';
import 'package:new_sai/presentation/pages/wallet_pages/wallet/getx/wallet_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class CashWithdrawalTabBar extends GetView<CashWithdrawalController> {
  const CashWithdrawalTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: TabBar(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        controller: controller.tabController,
        tabs: [
          // Tab(
          //   text: AppStrings.rewards,
          // ),
          Tab(
            text: AppStrings.cashWithDrawal,
          ),
          Tab(
            text: AppStrings.record,
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
