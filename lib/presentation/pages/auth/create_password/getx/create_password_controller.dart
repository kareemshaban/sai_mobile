import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/notification_services/notifications_service.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/use_case/auth_use_case/register_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class CreatePasswordController extends GetxController {
  final appController = Get.find<AppController>();
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  final RegisterUseCase _registerUseCase = instance<RegisterUseCase>();
  String phone = "";
  final RxBool _isPassword = true.obs;
  final RxBool _loading = false.obs;

  bool get isPassword => _isPassword.value;
  bool get loading => _loading.value;

  set isPassword(value) => _isPassword.value = value;
  set loading(value) => _loading.value = value;

  toggleIsPassword() {
    isPassword = !isPassword;
  }

  register() async {
    if (loading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      final params = AuthParams(
        phone: phone,
        password: passwordController.text,
        passwordConfirmation: passwordController.text,
      );
      loading = true;
      (await _registerUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) async {
          await _appPreferences.setUserToken(r.token);
          await appController.saveUser(r);
          NotificationsService.updateFcmToken();
          Get.toNamed(AppRoutes.profileDataRoute);
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
