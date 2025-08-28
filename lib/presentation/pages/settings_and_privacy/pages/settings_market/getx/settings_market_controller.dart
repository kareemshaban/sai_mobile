import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/settings_mapper.dart';
import 'package:new_sai/data/model/settings_model/setting_market_model.dart';
import 'package:new_sai/domain/entity/settings_entity/setting_market_entity.dart';
import 'package:new_sai/domain/entity/settings_entity/unique_id_entity.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_setting_market_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class SettingsMarketController extends GetxController {
  final appController = Get.find<AppController>();
  final GetSettingMarketUseCase _getSettingMarketUseCase =
      instance<GetSettingMarketUseCase>();

  final RxBool _loadingGetMarket = false.obs;
  final Rx<SettingMarketEntity> _market = SettingMarketModel().toDomain().obs;
  final RxList<UniqueIdEntity> _cat = <UniqueIdEntity>[].obs;

  bool get loadingGetMarket => _loadingGetMarket.value;
  SettingMarketEntity get market => _market.value;
  List<UniqueIdEntity> get cat => _cat;

  set loadingGetMarket(value) => _loadingGetMarket.value = value;
  set market(SettingMarketEntity value) => _market.value = value;
  set cat(List<UniqueIdEntity> value) => _cat.value = value;

  getMarket() async {
    loadingGetMarket = true;
    (await _getSettingMarketUseCase.execute("")).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        market = r;
        cat.addAll(r.user);
        cat.addAll(r.room);
      },
    );
    loadingGetMarket = false;
  }

  @override
  void onInit() async {
    await getMarket();
    super.onInit();
  }
}
