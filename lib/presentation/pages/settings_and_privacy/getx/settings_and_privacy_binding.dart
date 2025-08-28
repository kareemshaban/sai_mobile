import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/getx/settings_and_privacy_controller.dart';

class SettingsAndPrivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsAndPrivacyController());
  }
}
