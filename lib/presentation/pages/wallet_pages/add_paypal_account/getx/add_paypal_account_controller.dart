import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/wallet_params/withdraw_params.dart';
import 'package:new_sai/domain/use_case/wallet_use_case/withdraw_use_case.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/getx/cash_withdrawal_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class AddPaypalAccountController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final payPalIdTextCotnroller = TextEditingController();
  final confirmPayPalIdTextCotnroller = TextEditingController();
  final userNameTextController = TextEditingController();
  final countryTextController = TextEditingController();
  final withdrawUseCase = instance<WithdrawUseCase>();
  final _isLoading = false.obs;
  final _acceptTerms = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;
  bool get acceptTerms => _acceptTerms.value;
  set acceptTerms(bool value) => _acceptTerms.value = value;
  late String withdrawValue;
  @override
  void onInit() {
    withdrawValue =
        Get.find<CashWithdrawalController>().goldValueController.text;
    super.onInit();
  }

  chanveAcceptTemsValue(bool? value) {
    _acceptTerms.value = value!;
  }

  withdrawRequest() async {
    if (isLoading) return;
    if (formKey.currentState!.validate()) {
      if (acceptTerms) {
        isLoading = true;
        var result = await withdrawUseCase.execute(WithdrawParams(
            userName: userNameTextController.text,
            transferType: TransferType.paypal,
            withdrawValue: withdrawValue,
            countyName: countryTextController.text,
            payPalId: payPalIdTextCotnroller.text,
            payPalRepeat: confirmPayPalIdTextCotnroller.text));
        result.fold((ifLeft) {
          showSnackBarWidget(message: ifLeft.message);
        }, (ifRight) {
          Get.until((route) => route.settings.name == AppRoutes.mainRoute);
        });
        isLoading = false;
      } else {
        showSnackBarWidget(message: AppStrings.acceptInformationIsTrue);
      }
    }
    isLoading = false;
  }
}
