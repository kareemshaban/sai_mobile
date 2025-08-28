import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/wallet_params/withdraw_params.dart';
import 'package:new_sai/domain/use_case/wallet_use_case/withdraw_use_case.dart';
import 'package:new_sai/presentation/pages/wallet_pages/cash_withdrawal/getx/cash_withdrawal_controller.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class AddBankAccountController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final userNameTextController = TextEditingController();
  final bankNumberTextController = TextEditingController();
  final bankNameTextCotnroller = TextEditingController();
  final countyNameTextController = TextEditingController();
  final withdrawUseCase = instance<WithdrawUseCase>();
  final _acceptTerms = false.obs;
  final _isLoading = false.obs;
  late String withdrawValue;
  bool get acceptTerms => _acceptTerms.value;
  bool get isLoading => _isLoading.value;
  set acceptTerms(bool value) => _acceptTerms.value = value;
  set isLoading(bool value) => _isLoading.value = value;

  sendWithdrawRequest() async {
    if (isLoading) return;
    if (formKey.currentState!.validate()) {
      if (acceptTerms) {
        isLoading = true;
        var result = await withdrawUseCase.execute(WithdrawParams(
            bankName: bankNameTextCotnroller.text,
            ibanBankNumber: bankNumberTextController.text,
            userName: userNameTextController.text,
            transferType: TransferType.bank,
            withdrawValue: withdrawValue,
            countyName: countyNameTextController.text));
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
  }

  changeAcceptTemsValue(bool? value) {
    _acceptTerms.value = value!;
  }

  @override
  void onInit() {
    withdrawValue =
        Get.find<CashWithdrawalController>().goldValueController.text;
    super.onInit();
  }
}
