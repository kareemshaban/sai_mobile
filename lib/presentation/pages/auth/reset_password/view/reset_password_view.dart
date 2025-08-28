import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/auth/reset_password/getx/reset_password_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/eye_for_password.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.createPassword,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s17(context),
                ),
              ),
              12.verticalSpace(),
              Obx(
                () => AppFormFiled(
                  controller: controller.passwordController,
                  hint: AppStrings.enterYourPassword,
                  validator: AppValidation.validatePassword,
                  prefixIcon: EyeForPassword(
                    isPassword: controller.isPassword,
                    onTap: controller.toggleIsPassword,
                  ),
                  isPassword: controller.isPassword,
                ),
              ),
              20.verticalSpace(),
              Text(
                AppStrings.confirmPassword,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s17(context),
                ),
              ),
              12.verticalSpace(),
              Obx(
                () => AppFormFiled(
                  controller: controller.confirmPasswordController,
                  hint: AppStrings.enterYourPassword,
                  validator: (value) => AppValidation.validateConfirmPassword(
                      value, controller.passwordController.text),
                  prefixIcon: EyeForPassword(
                    isPassword: controller.conirmPassword,
                    onTap: controller.toggleConfirmPassword,
                  ),
                  isPassword: controller.conirmPassword,
                ),
              ),
              60.verticalSpace(),
              Obx(
                () => controller.loading
                    ? const Center(child: AppLoader())
                    : AppButton(
                        title: AppStrings.next,
                        width: 1.w(context),
                        onTap: controller.resetPassword,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
