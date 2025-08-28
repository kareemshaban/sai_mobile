import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/settings_params/change_email_phone_params.dart';
import 'package:new_sai/domain/use_case/settings_use_case/send_code_to_email_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ChangeEmailController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final SendCodeToEmailUseCase _sendCodeToEmailUseCase =
      instance<SendCodeToEmailUseCase>();

  final RxBool _loadingChangeEmail = false.obs;

  bool get loadingChangeEmail => _loadingChangeEmail.value;

  set loadingChangeEmail(value) => _loadingChangeEmail.value = value;

  sendCodeTOEmail() async {
    if (loadingChangeEmail) return;
    if (formKey.currentState!.validate()) {
      loadingChangeEmail = true;
      final params = ChangeEmailPhoneParams(
        email: emailController.text,
      );
      (await _sendCodeToEmailUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          Get.toNamed(
            AppRoutes.otpRoute,
            arguments: {
              "comeFrom": AppRoutes.changeEmailRoute,
              "phone": emailController.text,
            },
          );
        },
      );
      loadingChangeEmail = false;
    }
  }
}
