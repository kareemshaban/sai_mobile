import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/getx/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
  }
}
