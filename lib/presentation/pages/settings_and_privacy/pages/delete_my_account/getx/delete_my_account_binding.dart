import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/delete_my_account/getx/delete_my_account_controller.dart';

class DeleteMyAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DeleteMyAccountController());
  }
}
