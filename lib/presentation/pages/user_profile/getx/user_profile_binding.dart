import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/user_profile/getx/user_profile_controller.dart';

class UserProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserProfileController(), fenix: true);
  }
}
