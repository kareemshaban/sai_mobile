import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/change_mobile_number/getx/change_mobile_number_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/flag_for_form_filed.dart';

class ChangeMobileNumberView extends GetView<ChangeMobileNumberController> {
  const ChangeMobileNumberView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
      ),
      body: Form(
        key: controller.formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.enterNewNumber,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s17(context),
                ),
              ),
              12.verticalSpace(),
              Directionality(
                textDirection: TextDirection.ltr,
                child: AppFormFiled(
                  filledColor: Colors.transparent,
                  hint: AppStrings.enterNewNumber,
                  controller: controller.phoneController,
                  type: TextInputType.phone,
                  validator: AppValidation.validatePhone,
                  prefixIcon: Obx(
                    () => FlagForFormFiled(
                      flag: controller.countryNameCode,
                      code: controller.countryCode,
                      isName: true,
                      onTap: () => controller.showCountryPicker(context),
                    ),
                  ),
                ),
              ),
              60.verticalSpace(),
              Obx(
                () => Center(
                  child: controller.loadingSendPhone
                      ? const AppLoader()
                      : AppButton(
                          width: .7.w(context),
                          title: AppStrings.sendCode,
                          onTap: controller.sendCodeToPhone,
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
