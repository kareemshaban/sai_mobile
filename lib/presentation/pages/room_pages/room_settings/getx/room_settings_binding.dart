import 'package:get/get.dart';

import 'room_settings_controller.dart';

class RoomSettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RoomSettingsController());
  }
}
