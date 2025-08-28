import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/getx/my_stories_comment_and_views_controller.dart';

import 'my_stories_views_list.dart';

class MyStoriesViewsWidget extends GetView<MyStoriesCommentAndViewsController> {
  const MyStoriesViewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyStoriesViewsList();
  }
}
