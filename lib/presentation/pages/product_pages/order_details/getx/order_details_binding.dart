import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/product_pages/order_details/getx/order_details_controller.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailsController());
  }
}
