import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/data/params/settings_params/change_email_phone_params.dart';
import 'package:new_sai/domain/use_case/settings_use_case/send_code_to_phone_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ChangeMobileNumberController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final countryPicker = getCountryCodeStyle();
  final SendCodeToPhoneUseCase _codeToPhoneUseCase =
      instance<SendCodeToPhoneUseCase>();

  final RxString _countryNameCode = "QA".obs;
  final RxString _countryCode = "+974".obs;
  final RxBool _loadingSendPhone = false.obs;

  String get countryNameCode => _countryNameCode.value;
  String get countryCode => _countryCode.value;
  bool get loadingSendPhone => _loadingSendPhone.value;

  set countryNameCode(value) => _countryNameCode.value = value;
  set countryCode(value) => _countryCode.value = value;
  set loadingSendPhone(value) => _loadingSendPhone.value = value;

  showCountryPicker(BuildContext context) async {
    final country = await countryPicker.showPicker(context: context);

    if (country != null) {
      countryNameCode = country.code;
      countryCode = country.dialCode;
    }
  }

  sendCodeToPhone() async {
    if (loadingSendPhone) return;
    if (formKey.currentState!.validate()) {
      loadingSendPhone = true;
      final params = ChangeEmailPhoneParams(
        phone: countryCode + phoneController.text,
      );
      (await _codeToPhoneUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          Get.toNamed(
            AppRoutes.otpRoute,
            arguments: {
              "comeFrom": AppRoutes.changeMobileNumberRoute,
              "phone": countryCode + phoneController.text,
            },
          );
        },
      );
      loadingSendPhone = false;
    }
  }
}
