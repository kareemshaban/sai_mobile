import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/domain/use_case/settings_use_case/update_language_use_case.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:x_overlay/x_overlay.dart';

class LanguageController extends GetxController {
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final UpdateLanguageUseCase _updateLanguageUseCase =
  instance<UpdateLanguageUseCase>();

  final RxString _language = ''.obs;

  String get language => _language.value;

  set language(value) => _language.value = value;

  onChangeLanguageValue(value) {
    language = value;
  }

  onTapSaveLanguage(BuildContext context) async {
    if (Get.isRegistered<RoomController>()) {
      final roomController = Get.find<RoomController>();
      if (AppRoutes.overlayController.pageStateNotifier.value ==
          XOverlayPageState.overlaying) {
        AppRoutes.overlayController.hide();
        await roomController.closeAndDisposeRoom();
      }
    }
    if (language == "arabic") {
      await _appPreferences.setAppLanguage(arabic);
      if (context.mounted) {
        await context.setLocale(arabicLocale);
      }
      await Get.updateLocale(arabicLocale);
      await updateLanguage(arabic);
      Get.offAllNamed(AppRoutes.splashRoute);
    } else {
      await _appPreferences.setAppLanguage(english);
      if (context.mounted) {
        await context.setLocale(englishLocal);
      }
      await Get.updateLocale(englishLocal);
      await updateLanguage(english);
      Get.offAllNamed(AppRoutes.splashRoute);
    }
  }

  Future<bool> updateLanguage(String params) async {

    return (await _updateLanguageUseCase.execute(params)).fold(
          (l) {
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        showSnackBarWidget(message: l.message);
        return false;
      },
          (r) {
        // if (Get.isDialogOpen == true) {
        //   Get.back();
        // }
        // showSnackBarWidget(
        //     message: AppStrings.wasAppointed, color: ColorManager.green);
        return true;
      },
    );
  }



  getAppLanguage() {
    if (_appPreferences.getAppLanguage() == arabic) {
      language = "arabic";
    } else {
      language = "english";
    }
  }

  @override
  void onInit() {
    getAppLanguage();
    super.onInit();
  }
}
