import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/auth/profile_data/getx/profile_data_controller.dart';

class ProfileDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileDataController());
  }
}
