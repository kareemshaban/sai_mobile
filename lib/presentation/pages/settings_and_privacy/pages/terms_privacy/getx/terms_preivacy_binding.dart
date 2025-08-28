import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/terms_privacy/getx/terms_privacy_controller.dart';

class TermsPreivacyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TermsPrivacyController());
  }
}
