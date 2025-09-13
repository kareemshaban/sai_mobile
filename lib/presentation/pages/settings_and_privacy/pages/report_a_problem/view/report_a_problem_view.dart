import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/report_a_problem/getx/report_a_problem_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/report_a_problem/widgets/report_dialog.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/widget/setting_item.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';

class ReportAProblemView extends GetView<ReportAProblemController> {
  const ReportAProblemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        title: Text(AppStrings.reportAProblem) ,
        leading: const AppBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                AppStrings.doYouHaveAProblem,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s17(context),
                  fontWeight: FontWeightManger.semiBold,
                ),
              ),
            ),
            13.verticalSpace(),
            Container(
              width: 1.w(context),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              color: ColorManager.white,
              child: Column(
                children: [
                  SettingItem(
                    title: AppStrings.account,
                    onTap: () =>
                        Get.dialog(const ReportDialog(type: "interaction")),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    title: AppStrings.interaction,
                    onTap: () => Get.dialog(const ReportDialog(type: "bounce")),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    title: AppStrings.rewards,
                    onTap: () =>
                        Get.dialog(const ReportDialog(type: "account")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
