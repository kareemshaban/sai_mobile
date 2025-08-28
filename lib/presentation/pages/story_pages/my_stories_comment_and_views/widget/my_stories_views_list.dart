import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/getx/my_stories_comment_and_views_controller.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

import 'my_stories_views_item.dart';

class MyStoriesViewsList extends GetView<MyStoriesCommentAndViewsController> {
  const MyStoriesViewsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingViews
          ? const Center(child: AppLoader())
          : RefreshIndicator(
              onRefresh: () => controller.getStoryViews(),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemBuilder: (context, index) => MyStoriesViewsItem(
                  model: controller.views[index],
                ),
                separatorBuilder: (context, index) => 10.verticalSpace(),
                itemCount: controller.views.length,
              ),
            ),
    );
  }
}
