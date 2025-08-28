import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/auth/otp/getx/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpController());
  }
}
