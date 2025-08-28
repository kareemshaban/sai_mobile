import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/notifications/getx/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationsController());
  }
}
