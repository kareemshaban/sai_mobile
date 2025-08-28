import 'package:get/get.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/domain/use_case/auth_use_case/logout_use_case.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:x_overlay/x_overlay.dart';

class SettingsAndPrivacyController extends GetxController {
  final LogoutUseCase _logoutUseCase = instance<LogoutUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  logout() async {
    showAppLoadingDialog();
    (await _logoutUseCase.execute('')).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) async {
        if (Get.isRegistered<RoomController>()) {
          final roomController = Get.find<RoomController>();
          if (AppRoutes.overlayController.pageStateNotifier.value ==
              XOverlayPageState.overlaying) {
            AppRoutes.overlayController.hide();
            await roomController.closeAndDisposeRoom();
          }
        }
        Get.back();
        _appPreferences.logout();
        Get.offAllNamed(AppRoutes.loginRegisterRoute);
      },
    );
  }
}
