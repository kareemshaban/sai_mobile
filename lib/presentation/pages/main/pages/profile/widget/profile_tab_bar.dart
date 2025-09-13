import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
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
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: AppIcon(
                icon: IconsAssets.grid,
                color: controller.currentIndex == 0
                    ? ColorManager.black
                    : ColorManager.iconGreyColor,
                width: 20.0,
                height: 20.0,
              ),
            ),
            text: AppStrings.myReels,
          ),
          Tab(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: AppIcon(
                icon: IconsAssets.saved,
                color: controller.currentIndex == 1
                    ? ColorManager.black
                    : ColorManager.iconGreyColor,
                width: 20.0,
                height: 20.0,
              ),
            ),
            text: AppStrings.savedReels,
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
