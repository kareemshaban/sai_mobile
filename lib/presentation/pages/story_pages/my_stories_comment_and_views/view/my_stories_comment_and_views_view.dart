import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/getx/my_stories_comment_and_views_controller.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/widget/my_stories_comment_list.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/widget/my_stories_slider.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/widget/my_stories_tab_controller.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/widget/my_stories_views_list.dart';
import 'package:new_sai/presentation/pages/story_pages/my_story/getx/my_story_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class MyStoriesCommentAndViewsView
    extends GetView<MyStoriesCommentAndViewsController> {
  const MyStoriesCommentAndViewsView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyController = Get.find<MyStoryController>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                          Get.back();
                          storyController.storyController.play();
                    },
                    child: const Icon(
                      Icons.close,
                      color: ColorManager.white,
                      size: 25,
                    ),
                  ),
                  const Icon(
                    Icons.more_vert,
                    color: ColorManager.white,
                    size: 25,
                  ),
                ],
              ),
            ),
            22.verticalSpace(),
            const MyStoriesSlider(),
            40.verticalSpace(),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const PositionedDirectional(
                    top: -23,
                    child: AppIcon(icon: IconsAssets.triangle),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    color: ColorManager.white,
                    child: Column(
                      children: [
                        const MyStoriesTabController(),
                        20.verticalSpace(),
                        Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: const [
                              MyStoriesViewsList(),
                              MyStoriesCommentList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
