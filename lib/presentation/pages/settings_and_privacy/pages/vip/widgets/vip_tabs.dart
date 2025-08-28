import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class VipTabs extends GetView<VipController> {
  const VipTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DefaultTabController(
        length: controller.premium.data.length,
        child: TabBar(
          controller: controller.tabController,
          tabs: List.generate(
            controller.premium.data.length,
            (index) {
              return Tab(
                text: controller.premium.data[index].name,
              );
            },
          ),
          labelStyle: Get.textTheme.titleSmall!.copyWith(
            fontSize: AppSize.s18(context),
          ),
          unselectedLabelStyle: Get.textTheme.titleSmall!.copyWith(
            fontSize: AppSize.s18(context),
            color: ColorManager.black.withOpacity(.4),
          ),
        ),
      ),
    );
  }
}
