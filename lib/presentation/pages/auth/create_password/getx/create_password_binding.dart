import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/auth/create_password/getx/create_password_controller.dart';

class CreatePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreatePasswordController());
  }
}
