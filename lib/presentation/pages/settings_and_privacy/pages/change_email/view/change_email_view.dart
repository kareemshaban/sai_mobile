import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_email/getx/change_email_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class ChangeEmailView extends GetView<ChangeEmailController> {
  const ChangeEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.enterNewEmail,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s17(context),
                ),
              ),
              12.verticalSpace(),
              AppFormFiled(
                filledColor: Colors.transparent,
                hint: "example@gmail.com",
                controller: controller.emailController,
                type: TextInputType.emailAddress,
                validator: AppValidation.validateEmail,
                textDirection: TextDirection.ltr,
              ),
              60.verticalSpace(),
              Obx(
                () => Center(
                  child: controller.loadingChangeEmail
                      ? const AppLoader()
                      : AppButton(
                          onTap: controller.sendCodeTOEmail,
                          title: AppStrings.sendCode,
                          width: .7.w(context),
                        ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
