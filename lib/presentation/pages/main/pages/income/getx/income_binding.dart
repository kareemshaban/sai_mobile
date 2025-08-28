import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/main/pages/income/getx/income_controller.dart';

class IncomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IncomeController(), fenix: true);
  }
}
