import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/gallery/getx/gallery_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class GalleryTabBar extends GetView<GalleryController>
    implements PreferredSizeWidget {
  const GalleryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: TabBar(
        controller: controller.tabController,
        tabs: [
          Tab(
            text: AppStrings.all,
          ),
          Tab(
            text: AppStrings.videos,
          ),
          Tab(
            text: AppStrings.photos,
          ),
        ],
        labelStyle: Get.textTheme.titleMedium!.copyWith(
          fontSize: AppSize.s18(context),
        ),
        overlayColor: const WidgetStatePropertyAll(null),
        unselectedLabelStyle: Get.textTheme.titleMedium!.copyWith(
          fontSize: AppSize.s18(context),
          color: ColorManager.black.withOpacity(.5),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(40);
}
