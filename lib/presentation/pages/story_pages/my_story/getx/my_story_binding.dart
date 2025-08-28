import 'package:get/get.dart';

import 'my_story_controller.dart';

class MyStoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyStoryController());
  }
}
