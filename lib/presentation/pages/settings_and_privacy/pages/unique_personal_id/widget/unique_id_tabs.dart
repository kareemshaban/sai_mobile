import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class UniqueIdTabs extends GetView<UniquePersonalIdController> {
  const UniqueIdTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DefaultTabController(
        length: controller.market.subcategories.length,
        child: TabBar(
          controller: controller.tabController,
          tabs: List.generate(
            controller.market.subcategories.length,
            (index) {
              return Tab(
                text: controller.market.subcategories[index].name,
              );
            },
          ),
          onTap: (value) {
            controller.currentIndex = value;
            controller.getProduct();
          },
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          indicatorColor: ColorManager.black,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 1,
          labelPadding: const EdgeInsets.symmetric(horizontal: 16),
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
