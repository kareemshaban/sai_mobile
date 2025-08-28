import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/use_case/auth_use_case/forget_password_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final ForgetPasswordUseCase _forgetPasswordUseCase =
      instance<ForgetPasswordUseCase>();
  final countryPicker = getCountryCodeStyle();

  final RxString _flag = "assets/flags/qa.png".obs;
  final RxString _countryCode = "+974".obs;
  final RxBool _loading = false.obs;

  String get flag => _flag.value;
  String get countryCode => _countryCode.value;
  bool get loading => _loading.value;

  set flag(value) => _flag.value = value;
  set countryCode(value) => _countryCode.value = value;
  set loading(value) => _loading.value = value;

  showCountryPicker(BuildContext context) async {
    final country = await countryPicker.showPicker(context: context);

    if (country != null) {
      flag = country.flagUri;
      countryCode = country.dialCode;
    }
  }

  forgetPassword() async {
    if (loading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      final params = AuthParams(
        phone: countryCode + phoneController.text,
      );
      loading = true;
      (await _forgetPasswordUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          Get.toNamed(
            AppRoutes.otpRoute,
            arguments: {
              "comeFrom": AppRoutes.forgetPasswordRoute,
              "phone": countryCode + phoneController.text,
            },
          );
        },
      );
      loading = false;
    }
  }
}
