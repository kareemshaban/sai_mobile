import 'package:get/get.dart';

import 'friend_requests_controller.dart';

class FriendRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FriendRequestsController());
  }
}
