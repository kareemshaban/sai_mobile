import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/product_pages/category_search/getx/category_search_controller.dart';

class CategorySearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategorySearchController());
  }
}
