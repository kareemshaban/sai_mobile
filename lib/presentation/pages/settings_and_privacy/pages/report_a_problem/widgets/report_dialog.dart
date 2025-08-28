import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/report_a_problem/getx/report_a_problem_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class ReportDialog extends GetView<ReportAProblemController> {
  final String type;
  const ReportDialog({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.scaffoldBackground,
      surfaceTintColor: ColorManager.scaffoldBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(20),
      child: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.doYouHaveAProblem,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              20.verticalSpace(),
              AppFormFiled(
                controller: controller.messageController,
                validator: AppValidation.validateEmpty,
                lineCount: 10,
                label: AppStrings.pleaseTellUsWhatProblemYouAreFacing,
              ),
              20.verticalSpace(),
              Obx(
                () => controller.loadingReport
                    ? const AppLoader()
                    : AppButton(
                        title: AppStrings.send,
                        width: 1.w(context),
                        onTap: () => controller.report(type),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
