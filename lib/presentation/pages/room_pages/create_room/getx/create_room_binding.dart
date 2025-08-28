import 'package:get/get.dart';

import 'create_room_controller.dart';

class CreateRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateRoomController());
  }
}
