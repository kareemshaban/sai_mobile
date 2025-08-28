import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/settings_params/change_password_params.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_password_use_case.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  final ChangePasswordUseCase _changePasswordUseCase =
      instance<ChangePasswordUseCase>();

  final RxBool _loadingChangePassword = false.obs;
  final RxBool _isShowOldPassword = true.obs;
  final RxBool _isShowNewPassword = true.obs;

  bool get loadingChangePassword => _loadingChangePassword.value;
  bool get isShowOldPassword => _isShowOldPassword.value;
  bool get isShowNewPassword => _isShowNewPassword.value;

  set loadingChangePassword(value) => _loadingChangePassword.value = value;
  set isShowOldPassword(value) => _isShowOldPassword.value = value;
  set isShowNewPassword(value) => _isShowNewPassword.value = value;

  onChangeShowOldPassword() {
    isShowOldPassword = !isShowOldPassword;
  }

  onChangeShowNewPassword() {
    isShowNewPassword = !isShowNewPassword;
  }

  changePassword() async {
    if (loadingChangePassword) return;
    if (formKey.currentState!.validate()) {
      loadingChangePassword = true;
      final params = ChangePasswordParams(
        oldPassword: oldPasswordController.text,
        password: newPasswordController.text,
      );
      (await _changePasswordUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          Get.until((route) {
            if (Get.currentRoute == AppRoutes.accountRoute) {
              return true;
            }
            return false;
          });
          showSnackBarWidget(
            message: AppStrings.passwordChangedSuccessfully,
            color: ColorManager.green,
          );
        },
      );
      loadingChangePassword = false;
    }
  }
}
