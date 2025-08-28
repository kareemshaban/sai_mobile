import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/posts/search_post/getx/search_post_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class SearchPostTabBar extends GetView<SearchPostController> {
  const SearchPostTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: TabBar(
        controller: controller.tabController,
        isScrollable: true,
        onTap: controller.onChangeCurrentIndex,
        tabAlignment: TabAlignment.start,
        labelPadding: const EdgeInsets.symmetric(horizontal: 25),
        tabs: [
          Tab(text: AppStrings.all),
          Tab(text: AppStrings.videos),
          Tab(text: AppStrings.users),
          Tab(text: AppStrings.theHashtags),
        ],
        indicatorColor: ColorManager.black,
        labelStyle: Get.textTheme.titleSmall!.copyWith(
          fontSize: AppSize.s15(context),
        ),
        unselectedLabelStyle: Get.textTheme.titleSmall!.copyWith(
          fontSize: AppSize.s15(context),
          color: ColorManager.black.withOpacity(.5),
        ),
        overlayColor: const WidgetStatePropertyAll(ColorManager.transparent),
      ),
    );
  }
}
