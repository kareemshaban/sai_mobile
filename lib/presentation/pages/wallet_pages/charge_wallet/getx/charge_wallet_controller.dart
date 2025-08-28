import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/domain/entity/wallet_entity/units_entity.dart';
import 'package:new_sai/domain/use_case/wallet_use_case/get_charging_units_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ChargeWalletController extends GetxController {
  // final userCoins = Get.find <AppController>().user.goldValue;
  final getChargingUnitUseCase = instance<GetChargingUnitsUseCase>();
  late UnitEntity unitEntity;
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
  getChargingUnits() async {
    isLoading = true;
    var result = await getChargingUnitUseCase.execute("");
    result.fold((ifLeft) {
      showSnackBarWidget(message: ifLeft.message);
    }, (units) {
      unitEntity = units;
    });
    isLoading = false;
  }

  @override
  void onInit() async {
    await getChargingUnits();
    super.onInit();
  }
}
