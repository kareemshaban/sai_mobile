import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/di/basic_di.dart';
import 'package:new_sai/data/params/settings_params/report_params.dart';
import 'package:new_sai/domain/use_case/settings_use_case/report_use_case.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';

class ReportAProblemController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final messageController = TextEditingController();
  final ReportUseCase _reportUseCase = instance<ReportUseCase>();

  final RxBool _loadingReport = false.obs;

  bool get loadingReport => _loadingReport.value;

  set loadingReport(value) => _loadingReport.value = value;

  report(String type) async {
    if (loadingReport) return;
    if (formKey.currentState!.validate()) {
      loadingReport = true;
      final params = ReportParams(
        type: type,
        message: messageController.text,
      );
      (await _reportUseCase.execute(params)).fold(
        (l) {
          showSnackBarWidget(message: l.message);
        },
        (r) {
          messageController.clear();
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          showSnackBarWidget(
            message: AppStrings
                .theComplaintHasBeenSentSuccessfullyYouWillBeContactedSoon,
            color: ColorManager.green,
          );
        },
      );
      loadingReport = false;
    }
  }
}
