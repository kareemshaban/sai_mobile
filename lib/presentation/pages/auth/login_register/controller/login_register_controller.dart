import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/app/notification_services/notifications_service.dart';
import 'package:new_sai/data/params/auth_params/auth_params.dart';
import 'package:new_sai/domain/use_case/auth_use_case/login_use_case.dart';
import 'package:new_sai/domain/use_case/auth_use_case/register_verification_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class LoginRegisterController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final appController = Get.find<AppController>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final countryPicker = getCountryCodeStyle();
  final formKey = GlobalKey<FormState>();
  final LoginUseCase _loginUseCase = instance<LoginUseCase>();
  final RegisterVerificationUseCase _registerUseCase =
      instance<RegisterVerificationUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();
  late TabController tabController;
  final RxInt _tabIndex = 1.obs;
  final RxString _flag = "assets/flags/qa.png".obs;
  final RxString _countryCode = "+974".obs;
  final RxBool _isPassword = true.obs;
  final RxBool _loading = false.obs;

  int get tabIndex => _tabIndex.value;
  String get flag => _flag.value;
  String get countryCode => _countryCode.value;
  bool get isPassword => _isPassword.value;
  bool get loading => _loading.value;

  set tabIndex(value) => _tabIndex.value = value;
  set flag(value) => _flag.value = value;
  set countryCode(value) => _countryCode.value = value;
  set isPassword(value) => _isPassword.value = value;
  set loading(value) => _loading.value = value;

  showCountryPicker(BuildContext context) async {
    final country = await countryPicker.showPicker(context: context);

    if (country != null) {
      flag = country.flagUri;
      countryCode = country.dialCode;
    }
  }

  toggleIsPassword() {
    isPassword = !isPassword;
  }

  login() async {
    if (loading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      loading = true;
      final params = AuthParams(
        phone: countryCode + phoneController.text,
        password: passwordController.text,
      );
      (await _loginUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) async {
          print("sfsdf" + r.token);
          await _appPreferences.setUserToken(r.token);
          await appController.saveUser(r);
          NotificationsService.updateFcmToken();
          Get.offAllNamed(AppRoutes.mainRoute);
        },
      );
      loading = false;
    }
  }

  register() async {
    if (loading) {
      return;
    }
    if (formKey.currentState!.validate()) {
      loading = true;
      final params = AuthParams(
        phone: countryCode + phoneController.text,
      );
      (await _registerUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          Get.toNamed(
            AppRoutes.otpRoute,
            arguments: {
              "comeFrom": AppRoutes.loginRegisterRoute,
              "phone": r.phone,
            },
          );
        },
      );
      loading = false;
    }
  }

  clearData() {
    formKey.currentState!.reset();
    phoneController.clear();
    passwordController.clear();
  }

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this, initialIndex: 1);
    tabController.addListener(() {
      tabIndex = tabController.index;
    });
    super.onInit();
  }
}
