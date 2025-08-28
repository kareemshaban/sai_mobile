import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/language/getx/language_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LanguageController());
  }
}
