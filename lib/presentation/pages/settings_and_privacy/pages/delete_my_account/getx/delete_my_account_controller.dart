import 'package:get/get.dart';
import 'package:new_sai/app/app_pref.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/domain/use_case/auth_use_case/delete_account_use_case.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class DeleteMyAccountController extends GetxController {
  final DeleteAccountUseCase _accountUseCase = instance<DeleteAccountUseCase>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final RxBool _confirmDelete = false.obs;

  bool get confirmDelete => _confirmDelete.value;

  set confirmDelete(value) => _confirmDelete.value = value;

  onChangeConfirmDelete(value) {
    confirmDelete = value;
  }

  deleteAccount() async {
    if (!confirmDelete) {
      showSnackBarWidget(
          message: AppStrings.youMustConfirmFirstBeforeDeletingYourAccount);
      return;
    }
    showAppLoadingDialog();
    (await _accountUseCase.execute("")).fold(
      (l) {
        Get.back();
        showSnackBarWidget(message: l.message);
      },
      (r) {
        Get.back();
        _appPreferences.logout();
        Get.offAllNamed(AppRoutes.loginRegisterRoute);
      },
    );
  }
}
