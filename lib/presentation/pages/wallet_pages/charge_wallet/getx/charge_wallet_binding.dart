import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/wallet_pages/charge_wallet/getx/charge_wallet_controller.dart';

class ChargeWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChargeWalletController());
  }
}
