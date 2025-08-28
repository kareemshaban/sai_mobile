import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class TopRoomsTabs extends GetView<TopRoomsController> {
  const TopRoomsTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: TabBar(
        controller: controller.tabController,
        tabs: [
          Tab(
            text: AppStrings.hour,
          ),
          Tab(
            text: AppStrings.day,
          ),
          Tab(
            text: AppStrings.week,
          ),
          Tab(
            text: AppStrings.month,
          ),
        ],
        onTap: (value) {
          controller.getGlobal();
        },
        padding: const EdgeInsets.symmetric(horizontal: 25),
        indicatorPadding: EdgeInsets.zero,
        indicatorColor: ColorManager.primary,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: Get.textTheme.displayLarge!.copyWith(
          fontSize: AppSize.s14(context),
        ),
        unselectedLabelStyle: Get.textTheme.titleSmall!.copyWith(
          fontSize: AppSize.s14(context),
        ),
      ),
    );
  }
}
