import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/main/pages/rooms/getx/rooms_controller.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

import 'rooms_app_bar_filter_item.dart';

class RoomsAppBar extends GetView<RoomsController>
    implements PreferredSizeWidget {
  const RoomsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: isGuest()
          ? null
          : PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoomsAppBarFilterItem(
                      title: AppStrings.myOwn,
                      isActive: controller.currentIndex == 0,
                      onTap: () => controller.currentIndex == 0
                          ? null
                          : controller.onChangeIndex(0),
                    ),
                    RoomsAppBarFilterItem(
                      title: AppStrings.common,
                      isActive: controller.currentIndex == 1,
                      onTap: () => controller.currentIndex == 1
                          ? null
                          : controller.onChangeIndex(1),
                    ),
                    RoomsAppBarFilterItem(
                      title: AppStrings.general,
                      isActive: controller.currentIndex == 2,
                      onTap: () => controller.currentIndex == 2
                          ? null
                          : controller.onChangeIndex(2),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
