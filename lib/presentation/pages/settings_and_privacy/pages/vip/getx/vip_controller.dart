import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/settings_mapper.dart';
import 'package:new_sai/data/model/settings_model/premium_model.dart';
import 'package:new_sai/domain/entity/settings_entity/premium_entity.dart';
import 'package:new_sai/domain/use_case/settings_use_case/activate_premium_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/get_premium_list_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/renew_premium_use_case.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class VipController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final appController = Get.find<AppController>();
  late TabController tabController;
  final GetPremiumListUseCase _getPremiumListUseCase =
      instance<GetPremiumListUseCase>();
  final ActivatePremiumUseCase _activatePremiumUseCase =
      instance<ActivatePremiumUseCase>();
  final RenewPremiumUseCase _renewPremiumUseCase =
      instance<RenewPremiumUseCase>();

  final RxInt _currentIndex = 0.obs;
  final Rx<PremiumEntity> _premium = PremiumModel().toDomain().obs;
  final RxBool _loadingGetPremium = false.obs;

  int get currentIndex => _currentIndex.value;
  PremiumEntity get premium => _premium.value;
  bool get loadingGetPremium => _loadingGetPremium.value;

  set currentIndex(value) => _currentIndex.value = value;
  set premium(PremiumEntity value) => _premium.value = value;
  set loadingGetPremium(value) => _loadingGetPremium.value = value;

  getPremium() async {
    loadingGetPremium = true;
    (await _getPremiumListUseCase.execute("")).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        premium = r;
      },
    );
    loadingGetPremium = false;
  }

  activatePreium() async {
    showAppLoadingDialog();
    (await _activatePremiumUseCase.execute(premium.data[currentIndex].id)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        getPremium();
      },
    );
  }

  renewPreium() async {
    showAppLoadingDialog();
    (await _renewPremiumUseCase.execute(premium.data[currentIndex].id)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        getPremium();
      },
    );
  }

  @override
  void onInit() async {
    await getPremium();
    tabController = TabController(length: premium.data.length, vsync: this);
    tabController.addListener(() {
      currentIndex = tabController.index;
    });
    super.onInit();
  }
}
