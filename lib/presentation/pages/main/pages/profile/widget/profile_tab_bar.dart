import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class ProfileTabBar extends GetView<ProfileController>
    implements PreferredSizeWidget {
  const ProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TabBar(
        controller: controller.tabController,
        tabs: [
          Tab(
            icon: AppIcon(
              icon: IconsAssets.grid,
              color: controller.currentIndex == 0
                  ? ColorManager.black
                  : ColorManager.iconGreyColor,
            ),
          ),
          Tab(
            icon: AppIcon(
              icon: IconsAssets.saved,
              color: controller.currentIndex == 1
                  ? ColorManager.black
                  : ColorManager.iconGreyColor,
            ),
          ),
        ],
        indicatorColor: ColorManager.black,
        unselectedLabelColor: ColorManager.iconGreyColor,
        labelColor: ColorManager.black,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 50),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}
