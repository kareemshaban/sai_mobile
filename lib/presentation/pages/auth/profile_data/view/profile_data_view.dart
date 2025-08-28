import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/auth/profile_data/getx/profile_data_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class ProfileDataView extends GetView<ProfileDataController> {
  const ProfileDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:
            AppBackButton(onTap: () => Get.offAllNamed(AppRoutes.mainRoute)),
        leadingWidth: 60,
        title: Text(AppStrings.profileData),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 28),
        child: Obx(
          () => Form(
            key: controller.formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: controller.onPickImage,
                  child: Container(
                    width: 115,
                    height: 115,
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: ColorManager.lightGreyColor.withOpacity(.4),
                      shape: BoxShape.circle,
                      image: controller.imagePath.isNotEmpty
                          ? DecorationImage(
                              image: FileImage(File(controller.imagePath)),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: controller.imagePath.isNotEmpty
                        ? null
                        : Image.asset(
                            ImageAssets.camera,
                          ),
                  ),
                ),
                54.verticalSpace(),
                AppFormFiled(
                  hint: AppStrings.name,
                  controller: controller.nameController,
                  validator: AppValidation.validateEmpty,
                ),
                28.verticalSpace(),
                AppFormFiled(
                  hint: AppStrings.dateOfBirth,
                  controller: controller.dateController,
                  validator: AppValidation.validateEmpty,
                  suffixIcon: const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.iconGreyColor,
                    size: 20,
                  ),
                  readOnly: true,
                  onTap: () {
                    onTapDate(context, controller: controller.dateController);
                  },
                ),
                28.verticalSpace(),
                AppFormFiled(
                  hint: AppStrings.chooseYourNationality,
                  controller: controller.countryController,
                  suffixIcon: const Icon(
                    Icons.arrow_forward_ios,
                    color: ColorManager.iconGreyColor,
                    size: 20,
                  ),
                  readOnly: true,
                  onTap: controller.onTapCountry,
                ),
                28.verticalSpace(),
                Container(
                  width: 1.w(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: ColorManager.black.withOpacity(.3)),
                    color: ColorManager.white,
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.onTapGender("male"),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                  bottomStart: Radius.circular(8),
                                  topStart: Radius.circular(8),
                                ),
                                color: controller.gender == "male"
                                    ? ColorManager.primary
                                    : null,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                AppStrings.male,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s17(context),
                                  color: controller.gender == "male"
                                      ? ColorManager.white
                                      : ColorManager.black.withOpacity(.4),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const VerticalDivider(width: 0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.onTapGender("female"),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadiusDirectional.only(
                                  bottomEnd: Radius.circular(8),
                                  topEnd: Radius.circular(8),
                                ),
                                color: controller.gender == "female"
                                    ? ColorManager.primary
                                    : null,
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                AppStrings.female,
                                textAlign: TextAlign.center,
                                style: Get.textTheme.titleSmall!.copyWith(
                                  fontSize: AppSize.s17(context),
                                  color: controller.gender == "female"
                                      ? ColorManager.white
                                      : ColorManager.black.withOpacity(.4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                63.verticalSpace(),
                controller.loading
                    ? const Center(child: AppLoader())
                    : AppButton(
                        title: AppStrings.next,
                        onTap: controller.updateProfile,
                        width: 1.w(context),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
