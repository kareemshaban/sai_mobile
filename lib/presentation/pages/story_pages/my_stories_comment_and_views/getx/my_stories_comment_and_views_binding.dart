import 'package:get/get.dart';

import 'my_stories_comment_and_views_controller.dart';

class MyStoriesCommentAndViewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyStoriesCommentAndViewsController());
  }
}
