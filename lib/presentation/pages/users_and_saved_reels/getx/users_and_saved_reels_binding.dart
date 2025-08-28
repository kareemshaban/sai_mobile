import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/users_and_saved_reels/getx/users_and_saved_reels_controller.dart';

class UsersAndSavedReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UsersAndSavedReelsController());
  }
}
