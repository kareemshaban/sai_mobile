import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

import 'top_filter_widget.dart';

class TopRoomsFilterWidget extends GetView<TopRoomsController> {
  const TopRoomsFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: ColorManager.black.withOpacity(.25)),
      ),
      child: Obx(
        () => Row(
          children: [
            TopFilterWidget(
              title: AppStrings.topRooms,
              onTap: () => controller.onChangeFilterValue("topRooms"),
              isActive: controller.filterValue == "topRooms",
            ),
            TopFilterWidget(
              title: AppStrings.topSenders,
              onTap: () => controller.onChangeFilterValue("topSenders"),
              isActive: controller.filterValue == "topSenders",
            ),
            TopFilterWidget(
              title: AppStrings.billionaire,
              onTap: () => controller.onChangeFilterValue("billionaire"),
              isActive: controller.filterValue == "billionaire",
            ),
          ],
        ),
      ),
    );
  }
}
