import 'package:get/get.dart';

import 'cash_withdrawal_controller.dart';

class CashWithdrawalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CashWithdrawalController());
  }
}
