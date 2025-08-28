import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/game/view/game_page.dart';

import 'room_controller.dart';

class RoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RoomController(), permanent: true);
    // Get.put(WebViewStateController(), permanent: true);
  }
}
