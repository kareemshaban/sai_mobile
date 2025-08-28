import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/settings_market/getx/settings_market_controller.dart';

class SettingsMarketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsMarketController());
  }
}
