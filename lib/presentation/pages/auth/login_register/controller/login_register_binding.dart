import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/auth/login_register/controller/login_register_controller.dart';

class LoginRegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRegisterController());
  }
}
