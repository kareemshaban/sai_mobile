import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/country_room/getx/country_room_controller.dart';

class CountryRoomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountryRoomController());
  }
}
