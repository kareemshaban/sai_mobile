import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/privacy/getx/privacy_controller.dart';

class PrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PrivacyController());
  }
}
