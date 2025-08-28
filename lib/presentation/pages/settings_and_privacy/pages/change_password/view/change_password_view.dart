import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_password/getx/change_password_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/eye_for_password.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.changePassword),
      ),
      body: Obx(
        () => Form(
          key: controller.formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.oldPassword,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s17(context),
                  ),
                ),
                12.verticalSpace(),
                AppFormFiled(
                  filledColor: Colors.transparent,
                  hint: AppStrings.enterYourPassword,
                  controller: controller.oldPasswordController,
                  isPassword: controller.isShowOldPassword,
                  validator: AppValidation.validatePassword,
                  suffixIcon: EyeForPassword(
                    isPassword: controller.isShowOldPassword,
                    onTap: controller.onChangeShowOldPassword,
                  ),
                ),
                20.verticalSpace(),
                Text(
                  AppStrings.newPassword,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s17(context),
                  ),
                ),
                12.verticalSpace(),
                AppFormFiled(
                  filledColor: Colors.transparent,
                  hint: AppStrings.enterYourPassword,
                  controller: controller.newPasswordController,
                  isPassword: controller.isShowNewPassword,
                  validator: AppValidation.validatePassword,
                  suffixIcon: EyeForPassword(
                    isPassword: controller.isShowNewPassword,
                    onTap: controller.onChangeShowNewPassword,
                  ),
                ),
                60.verticalSpace(),
                Center(
                  child: controller.loadingChangePassword
                      ? const AppLoader()
                      : AppButton(
                          onTap: controller.changePassword,
                          title: AppStrings.next,
                          width: .7.w(context),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
