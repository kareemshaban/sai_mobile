import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/widgets/expired_subscription_widget.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/widgets/vip_bottom_button.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/widgets/vip_line_widget.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/widgets/vip_subscription_details_widget.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/widgets/vip_tabs.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class VipView extends GetView<VipController> {
  const VipView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        centerTitle: false,
        title: Text(AppStrings.saiVip),
        actions: [
          Obx(
            () => Text(
              controller
                  .appController.user.goldValue.formatCurrencyWithoutSymbol,
              style: Get.textTheme.displayLarge!.copyWith(
                fontSize: AppSize.s16(context),
              ),
            ),
          ),
          5.horizontalSpace(),
          const AppIcon(
            icon: IconsAssets.coins,
            width: 17,
            height: 17,
          ),
          16.horizontalSpace(),
        ],
      ),
      body: Obx(
        () => controller.loadingGetPremium
            ? const Center(child: AppLoader())
            : Column(
                children: [
                  if (controller.premium.isExpierd == 1)
                    const ExpiredSubscriptionWidget(),
                  const VipTabs(),
                  const VipLineWidget(),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: List.generate(
                        controller.premium.data.length,
                        (index) => const VipSubscriptionDetailsWidget(),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: const VipBottomButton(),
    );
  }
}
