import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/report_a_problem/getx/report_a_problem_controller.dart';

class ReportAProblemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReportAProblemController(), fenix: true);
  }
}
