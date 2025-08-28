import 'dart:io';

import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/mapper/app_mapper.dart';
import 'package:new_sai/data/model/app_model/app_info_model.dart';
import 'package:new_sai/domain/entity/app_entity/app_info_entity.dart';
import 'package:new_sai/domain/use_case/app_use_case/get_app_info_use_case.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:new_sai/presentation/widgets/update_app_dialog.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final image = ImageAssets.logoSplash;
  final appController = Get.find<AppController>();
  final GetAppInfoUseCase _appInfoUseCase = instance<GetAppInfoUseCase>();

  final RxBool _loading = false.obs;
  final RxBool _isError = false.obs;
  final RxString _currentVersion = "".obs;
  final Rx<AppInfoEntity> _appInfo = AppInfoModel().toDomain().obs;

  bool get loading => _loading.value;
  bool get isError => _isError.value;
  String get currentVersion => _currentVersion.value;
  AppInfoEntity get appInfo => _appInfo.value;

  set loading(value) => _loading.value = value;
  set isError(value) => _isError.value = value;
  set currentVersion(value) => _currentVersion.value = value;
  set appInfo(AppInfoEntity value) => _appInfo.value = value;

  goNext() {
    Get.offAllNamed(AppRoutes.mainRoute);
  }

  checkAppVersion() async {
    loading = true;
    isError = false;
    final packageInfo = await PackageInfo.fromPlatform();
    currentVersion = packageInfo.version;
    (await _appInfoUseCase.execute("")).fold(
      (l) {
        showSnackBarWidget(message: l.message);
        isError = true;
      },
      (r) {
        appInfo = r;
        appController.goldReddemeActive(appInfo.activateRedeemGolds == 1);
        appController.activeVip(appInfo.vip == "1");
        if (Platform.isIOS) {
          if (currentVersion != appInfo.iosVersion) {
            Get.dialog(
              UpdateAppDialog(
                link: appInfo.iosUrl,
              ),
              barrierDismissible: false,
            );
          } else {
            goNext();
          }
        } else {
          if (currentVersion != appInfo.androidVersion) {
            Get.dialog(
              UpdateAppDialog(
                link: appInfo.androidUrl,
              ),
              barrierDismissible: false,
            );
          } else {
            goNext();
          }
        }
      },
    );
    loading = false;
  }

  @override
  void onInit() async {
    await Future.delayed(const Duration(seconds: 3));
    await checkAppVersion();
    super.onInit();
  }
}
