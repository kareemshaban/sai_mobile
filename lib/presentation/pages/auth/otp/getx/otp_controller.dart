import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/data/params/settings_params/change_email_phone_params.dart';
import 'package:new_sai/domain/use_case/auth_use_case/verify_code_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/verify_forget_password_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_email_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/change_phone_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/send_code_to_email_use_case.dart';
import 'package:new_sai/domain/use_case/settings_use_case/send_code_to_phone_use_case.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class OtpController extends GetxController {
  final appController = Get.find<AppController>();
  final otpController = TextEditingController();
  late String comeFrom;
  String title = "";
  bool withButton = false;
  String phone = "";
  final VerifyCodeUseCase _verifyCodeUseCase = instance<VerifyCodeUseCase>();
  final VerifyForgetPasswordUseCase _verifyForgetPasswordUseCase =
      instance<VerifyForgetPasswordUseCase>();
  final ChangePhoneUseCase _changePhoneUseCase = instance<ChangePhoneUseCase>();
  final SendCodeToPhoneUseCase _codeToPhoneUseCase =
      instance<SendCodeToPhoneUseCase>();
  final ChangeEmailUseCase _changeEmailUseCase = instance<ChangeEmailUseCase>();
  final SendCodeToEmailUseCase _sendCodeToEmailUseCase =
      instance<SendCodeToEmailUseCase>();
  Timer? _timer;

  final Rx<Duration> _duration = const Duration(minutes: 2).obs;
  final RxBool _loadingSendCode = false.obs;

  Duration get duration => _duration.value;
  bool get loadingSendCode => _loadingSendCode.value;

  set duration(value) => _duration.value = value;
  set loadingSendCode(value) => _loadingSendCode.value = value;

  onSubmit() async {
    switch (comeFrom) {
      case AppRoutes.loginRegisterRoute:
        await verifyRegisterCode();
      case AppRoutes.forgetPasswordRoute:
        await verifyForgetPassword();
      case AppRoutes.changeMobileNumberRoute:
        await changePhone();
      case AppRoutes.changeEmailRoute:
        await changeEmail();
      default:
        null;
    }
  }

  onResendCode() async {
    switch (comeFrom) {
      case AppRoutes.changeMobileNumberRoute:
        await sendCodeToPhone();
      case AppRoutes.changeEmailRoute:
        await sendCodeToEmail();
      default:
        await sendCodeToPhone();
    }
  }

  verifyRegisterCode() async {
    showAppLoadingDialog();
    final params = AuthParams(
      phone: phone,
      code: otpController.text,
    );
    (await _verifyCodeUseCase.execute(params)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        Get.toNamed(
          AppRoutes.createPasswordRoute,
          arguments: {
            'phone': r.phone,
          },
        );
      },
    );
  }

  verifyForgetPassword() async {
    showAppLoadingDialog();
    final params = AuthParams(
      phone: phone,
      code: otpController.text,
    );
    (await _verifyForgetPasswordUseCase.execute(params)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        Get.toNamed(
          AppRoutes.resetPasswordRoute,
          arguments: {
            'phone': phone,
          },
        );
      },
    );
  }

  changePhone() async {
    showAppLoadingDialog();
    final params = ChangeEmailPhoneParams(
      phone: phone,
      code: otpController.text,
    );
    (await _changePhoneUseCase.execute(params)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        appController.user.phone = phone;
        appController.saveUser(appController.user);
        Get.until((route) {
          if (Get.currentRoute == AppRoutes.accountInformationRoute) {
            return true;
          }
          return false;
        });
        showSnackBarWidget(
            message: AppStrings.mobileNumberChangedSuccessfully,
            color: ColorManager.green);
      },
    );
  }

  changeEmail() async {
    showAppLoadingDialog();
    final params = ChangeEmailPhoneParams(
      email: phone,
      code: otpController.text,
    );
    (await _changeEmailUseCase.execute(params)).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        appController.user.email = phone;
        appController.saveUser(appController.user);
        Get.until((route) {
          if (Get.currentRoute == AppRoutes.accountInformationRoute) {
            return true;
          }
          return false;
        });
        showSnackBarWidget(
          message: AppStrings.emailChangedSuccessfully,
          color: ColorManager.green,
        );
      },
    );
  }

  sendCodeToPhone() async {
    if (loadingSendCode) return;
    loadingSendCode = true;
    final params = ChangeEmailPhoneParams(phone: phone);
    (await _codeToPhoneUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        showSnackBarWidget(
          message: AppStrings.theCodeHasBeenSentSuccessfully,
          color: ColorManager.green,
        );
        startTimer();
      },
    );
    loadingSendCode = false;
  }

  sendCodeToEmail() async {
    if (loadingSendCode) return;
    loadingSendCode = true;
    final params = ChangeEmailPhoneParams(email: phone);
    (await _sendCodeToEmailUseCase.execute(params)).fold(
      (l) {
        showSnackBarWidget(message: l.message);
      },
      (r) {
        showSnackBarWidget(
          message: AppStrings.theCodeHasBeenSentSuccessfully,
          color: ColorManager.green,
        );
        startTimer();
      },
    );
    loadingSendCode = false;
  }

  startTimer() {
    duration = const Duration(minutes: 2);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (duration.inSeconds > 0) {
          final oldDuration = duration;
          duration = Duration(seconds: oldDuration.inSeconds - 1);
        } else {
          cancelTimer();
        }
      },
    );
  }

  cancelTimer() {
    _timer?.cancel();
  }

  @override
  void onInit() {
    comeFrom = Get.arguments['comeFrom'];
    title = Get.arguments['title'] ?? "";
    withButton = Get.arguments['withButton'] ?? false;
    phone = Get.arguments['phone'] ?? "";
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    cancelTimer();
    super.onClose();
  }
}
