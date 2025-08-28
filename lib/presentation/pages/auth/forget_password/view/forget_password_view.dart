import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/auth/forget_password/getx/forget_password_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/flag_for_form_filed.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.forgetPassword),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              .15.h(context).verticalSpace(),
              Text(
                AppStrings.pleaseEnterYourPhoneNumber,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s24(context),
                ),
              ),
              .1.h(context).verticalSpace(),
              Obx(
                () => Directionality(
                  textDirection: TextDirection.ltr,
                  child: AppFormFiled(
                    validator: AppValidation.validatePhone,
                    controller: controller.phoneController,
                    type: TextInputType.phone,
                    prefixIcon: FlagForFormFiled(
                      flag: controller.flag,
                      code: controller.countryCode,
                      onTap: () => controller.showCountryPicker(context),
                    ),
                  ),
                ),
              ),
              .2.h(context).verticalSpace(),
              Text(
                AppStrings.youWillReceiveTheActivationCodeOnTheRegisteredNumber,
                style: Get.textTheme.titleMedium!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              10.verticalSpace(),
              Obx(
                () => controller.loading
                    ? const Center(child: AppLoader())
                    : AppButton(
                        title: AppStrings.next,
                        width: .7.w(context),
                        onTap: controller.forgetPassword,
                      ),
              ),
              10.verticalSpace(),
              InkWell(
                onTap: () => Get.back(),
                child: Text(
                  AppStrings.back,
                  style: Get.textTheme.titleMedium!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
