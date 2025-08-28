import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/pages/profile/getx/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ProfileController());
  }
}
