import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/use_case/auth_use_case/reset_password_use_case.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final ResetPasswordUseCase _resetPasswordUseCase =
      instance<ResetPasswordUseCase>();
  String phone = "";

  final RxBool _isPassword = true.obs;
  final RxBool _conirmPassword = true.obs;
  final RxBool _loading = false.obs;

  bool get isPassword => _isPassword.value;
  bool get conirmPassword => _conirmPassword.value;
  bool get loading => _loading.value;

  set isPassword(value) => _isPassword.value = value;
  set conirmPassword(value) => _conirmPassword.value = value;
  set loading(value) => _loading.value = value;

  toggleIsPassword() {
    isPassword = !isPassword;
  }

  toggleConfirmPassword() {
    conirmPassword = !conirmPassword;
  }

  resetPassword() async {
    if (loading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      loading = true;
      final params = AuthParams(
        phone: phone,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );
      (await _resetPasswordUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          showSnackBarWidget(
            message: r.message ?? "",
            color: ColorManager.green,
          );
          Get.until((route) {
            if (Get.currentRoute == AppRoutes.loginRegisterRoute) {
              return true;
            }
            return false;
          });
        },
      );
      loading = false;
    }
  }

  @override
  void onInit() {
    phone = Get.arguments['phone'] ?? "";
    super.onInit();
  }
}
