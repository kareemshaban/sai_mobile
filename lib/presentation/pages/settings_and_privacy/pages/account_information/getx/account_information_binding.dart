import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account_information/getx/account_information_controller.dart';

class AccountInformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountInformationController());
  }
}
