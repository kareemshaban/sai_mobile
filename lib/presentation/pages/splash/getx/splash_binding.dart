import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/splash/getx/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashController());
  }
}
