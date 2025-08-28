import 'package:get/get.dart';

import 'add_paypal_account_controller.dart';

class AddPaypalAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddPaypalAccountController());
  }
}
