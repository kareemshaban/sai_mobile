import 'package:get/get.dart';

import 'post_settings_controller.dart';

class PostSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostSettingsController());
  }
}
