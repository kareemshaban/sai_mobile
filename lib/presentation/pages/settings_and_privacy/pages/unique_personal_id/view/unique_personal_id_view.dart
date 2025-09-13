import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/widget/unique_id_list.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/widget/unique_id_tabs.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class UniquePersonalIdView extends GetView<UniquePersonalIdController> {
  const UniquePersonalIdView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(controller.market.name , style: TextStyle(fontSize: 16.0),),
        centerTitle: true,
        actions: [
          Obx(
            () => Text(
              controller
                  .appController.user.goldValue.formatCurrencyWithoutSymbol,
              style: Get.textTheme.displayLarge!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
          ),
          5.horizontalSpace(),
         const Padding(
            padding:  EdgeInsets.only(bottom: 5.0),
            child:  AppIcon(
              icon: IconsAssets.coins,
              width: 20,
              height: 20,
            ),
          ),
          16.horizontalSpace(),
        ],
      ),
      body: Column(
        children: [
          const UniqueIdTabs(),
          10.verticalSpace(),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              children: List.generate(
                controller.market.subcategories.length,
                (index) {
                  return const UniqueIdList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
