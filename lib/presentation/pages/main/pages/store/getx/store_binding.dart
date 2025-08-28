import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/pages/store/getx/store_controller.dart';

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoreController(), fenix: true);
  }
}
