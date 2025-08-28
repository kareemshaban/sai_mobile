import 'package:get/get.dart';

import 'search_post_controller.dart';

class SearchPostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchPostController());
  }
}
