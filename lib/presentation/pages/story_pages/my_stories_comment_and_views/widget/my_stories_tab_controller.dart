import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/getx/my_stories_comment_and_views_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class MyStoriesTabController
    extends GetView<MyStoriesCommentAndViewsController> {
  const MyStoriesTabController({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Obx(
        () => TabBar(
          controller: controller.tabController,
          tabs: [
            Tab(
              text:
                  "${AppStrings.views}(${controller.views.length})",
            ),
            Tab(
              text:
                  "${AppStrings.comments}(${controller.views.length})",
            ),
          ],
          labelStyle: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s18(context),
          ),
          unselectedLabelStyle: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s18(context),
            color: ColorManager.black.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}
