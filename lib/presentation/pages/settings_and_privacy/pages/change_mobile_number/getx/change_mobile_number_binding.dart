import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_mobile_number/getx/change_mobile_number_controller.dart';

class ChangeMobileNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeMobileNumberController());
  }
}
