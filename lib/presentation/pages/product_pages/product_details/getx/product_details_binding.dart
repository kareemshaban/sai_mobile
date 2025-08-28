import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/product_pages/product_details/getx/product_details_controller.dart';

class ProductDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProductDetailsController(),
      tag: Get.arguments.toString(),
    );
  }
}
