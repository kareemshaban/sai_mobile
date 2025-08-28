import 'package:get/get.dart';

import 'add_new_address_controller.dart';

class AddNewAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddNewAddressController());
  }
}
