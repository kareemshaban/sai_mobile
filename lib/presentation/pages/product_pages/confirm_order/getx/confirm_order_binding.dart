import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/product_pages/confirm_order/getx/confirm_order_controller.dart';

class ConfirmOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmOrderController());
  }
}
