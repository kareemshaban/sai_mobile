import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_controller.dart';

class UniquePersonalIdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UniquePersonalIdController());
  }
}
