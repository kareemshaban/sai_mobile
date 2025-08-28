import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_controller.dart';

class VipBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VipController());
  }
}
