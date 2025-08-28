import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/income/getx/income_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class MainBottomNavBar extends GetView<MainController> {
  const MainBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: controller.onChangeCurrentIndex,
        backgroundColor:
            controller.currentIndex == 2 ? ColorManager.black : null,
        unselectedItemColor:
            controller.currentIndex == 2 ? ColorManager.white : null,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding:const EdgeInsets.symmetric(vertical: 3.0),
              child: AppIcon(
                icon: IconsAssets.store,
                width: 30,
                height: 30,
                color: controller.currentIndex == 2
                    ? ColorManager.white
                    : controller.currentIndex == 0
                        ? ColorManager.primary
                        : ColorManager.black,
              ),
            ),
            label: AppStrings.store,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding:const EdgeInsets.symmetric(vertical: 3.0),
              child: AppIcon(
                icon: IconsAssets.chat,
                width: 30,
                height: 30,
                color: controller.currentIndex == 2
                    ? ColorManager.white
                    : controller.currentIndex == 1
                        ? ColorManager.primary
                        : ColorManager.black,
              ),
            ),
            label: AppStrings.chat,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding:const EdgeInsets.symmetric(vertical: 3.0),
              child: AppIcon(
                icon: IconsAssets.reels,
                width: 30,
                height: 30,
                color: controller.currentIndex == 2
                    ? ColorManager.primary
                    : ColorManager.black,
              ),
            ),
            label: AppStrings.reels,
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(vertical: 3.0),
                  child: AppIcon(
                    icon: IconsAssets.income,
                    width: 30,
                    height: 30,
                    color: controller.currentIndex == 2
                        ? ColorManager.white
                        : controller.currentIndex == 3
                            ? ColorManager.primary
                            : ColorManager.black,
                  ),
                ),
                if (Get.find<ProfileController>().notificationCount != 0 ||
                    Get.find<IncomeController>()
                        .myConversations
                        .where((element) => element.messagesCount != 0)
                        .toList()
                        .isNotEmpty)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: ColorManager.red,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            label: AppStrings.incoming,
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding:const EdgeInsets.symmetric(vertical: 3.0),
              child: AppIcon(
                icon: IconsAssets.user,
                width: 30,
                height: 30,
                color: controller.currentIndex == 2
                    ? ColorManager.white
                    : controller.currentIndex == 4
                        ? ColorManager.primary
                        : ColorManager.black,
              ),
            ),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }
}
