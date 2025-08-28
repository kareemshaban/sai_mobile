import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/getx/my_stories_comment_and_views_controller.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/pull_to_refresh_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import 'my_stories_comment_item.dart';

class MyStoriesCommentList extends GetView<MyStoriesCommentAndViewsController> {
  const MyStoriesCommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingComment
          ? const Center(child: AppLoader())
          : PullToRefreshWidget(
              controller: RefreshController(),
              scrollController: controller.commentScrollController,
              onRefresh: () => controller.getStoryComment(),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemBuilder: (context, index) => MyStoriesCommentItem(
                  model: controller.comments[index],
                ),
                separatorBuilder: (context, index) => 10.verticalSpace(),
                itemCount: controller.comments.length,
              ),
            ),
    );
  }
}
