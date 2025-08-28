import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_email/getx/change_email_controller.dart';

class ChangeEmailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeEmailController());
  }
}
