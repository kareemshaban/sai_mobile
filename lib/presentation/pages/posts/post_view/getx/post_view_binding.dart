import 'package:get/get.dart';

import 'post_view_controller.dart';

class PostViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostViewController());
  }
}
