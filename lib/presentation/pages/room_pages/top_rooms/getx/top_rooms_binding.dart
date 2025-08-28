import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/room_pages/top_rooms/getx/top_rooms_controller.dart';

class TopRoomsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopRoomsController());
  }
}
