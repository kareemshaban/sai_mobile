import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_password/getx/change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
