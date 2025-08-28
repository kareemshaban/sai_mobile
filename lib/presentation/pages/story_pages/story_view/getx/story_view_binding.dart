import 'package:get/get.dart';

import 'story_view_controller.dart';

class StoryViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoryViewController());
  }
}
