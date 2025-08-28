import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account/getx/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController());
  }
}
