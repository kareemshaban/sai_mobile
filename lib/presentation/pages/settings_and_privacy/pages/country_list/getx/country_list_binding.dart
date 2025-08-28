import 'package:get/get.dart';

import 'country_list_controller.dart';

class CountryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountryListController(), fenix: true);
  }
}
