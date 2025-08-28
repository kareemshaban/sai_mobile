import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/edit_profile/getx/edit_profile_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/edit_profile/widget/edit_profile_filed_sheet.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/edit_profile/widget/edit_profile_value_button.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/edit_profile/widget/gender_bottom_sheet.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leadingWidth: 60,
          leading: const AppBackButton(),
          title: Text(AppStrings.editProfile),
          actions: [
            if (controller.loading)
              const Center(
                child: AppLoader(),
              )
            else
              InkWell(
                onTap: controller.updateProfile,
                child: Text(
                  AppStrings.save,
                  style: Get.textTheme.displayLarge,
                ),
              ),
            16.horizontalSpace(),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.coverImage,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s20(context),
                    ),
                  ),
                  InkWell(
                    onTap: controller.pickCoverImage,
                    child: Text(
                      AppStrings.edit,
                      style: Get.textTheme.displaySmall!.copyWith(
                        fontSize: AppSize.s20(context),
                      ),
                    ),
                  ),
                ],
              ),
              26.verticalSpace(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 1.w(context),
                    height: 180,
                    decoration: BoxDecoration(
                      gradient: ColorManager.coverImageColor,
                      image: controller.coverImagePath.isEmpty
                          ? null
                          : DecorationImage(
                              image: FileImage(
                                File(controller.coverImagePath),
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: controller.appController.user.profileCover.isEmpty ||
                            controller.coverImagePath.isNotEmpty
                        ? null
                        : AppImage(
                            image: controller.appController.user.profileCover,
                            fit: BoxFit.cover,
                          ),
                  ),
                  InkWell(
                    onTap: controller.pickCoverImage,
                    child: Image.asset(
                      ImageAssets.camera,
                      width: 60,
                      height: 60,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
              22.verticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.profilePicture,
                    style: Get.textTheme.titleMedium!.copyWith(
                      fontSize: AppSize.s20(context),
                    ),
                  ),
                  InkWell(
                    onTap: controller.pickProfileImage,
                    child: Text(
                      AppStrings.edit,
                      style: Get.textTheme.displaySmall!.copyWith(
                        fontSize: AppSize.s20(context),
                      ),
                    ),
                  ),
                ],
              ),
              26.verticalSpace(),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: ColorManager.coverImageColor,
                      shape: BoxShape.circle,
                      image: controller.imagePath.isEmpty
                          ? null
                          : DecorationImage(
                              image: FileImage(
                                File(controller.imagePath),
                              ),
                              fit: BoxFit.cover,
                            ),
                    ),
                    child: controller.appController.user.profileImg.isEmpty ||
                            controller.imagePath.isNotEmpty
                        ? null
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: Image.network(
                              controller.appController.user.profileImg,
                              errorBuilder: (context, error, stackTrace) {
                                return const AppImage(
                                  image: Constants.userErrorWidget,
                                  width: 100,
                                  height: 100,
                                  isCircle: true,
                                );
                              },
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                  InkWell(
                    onTap: controller.pickProfileImage,
                    child: Image.asset(
                      ImageAssets.camera,
                      width: 30,
                      height: 30,
                      color: ColorManager.white,
                    ),
                  ),
                ],
              ),
              45.verticalSpace(),
              EditProfileValueButton(
                title: AppStrings.name,
                value: controller.name,
                onTap: () async {
                  controller.name = await Get.bottomSheet(
                        EditProfileFiledSheet(
                          label: AppStrings.editYourName,
                          hint: AppStrings.fullName,
                          value: controller.name,
                          withValidation: true,
                        ),
                      ) ??
                      controller.name;
                },
              ),
              EditProfileValueButton(
                title: AppStrings.gender,
                value: controller.gender,
                onTap: () async {
                  controller.gender = await Get.bottomSheet(
                        GenderBottomSheet(value: controller.gender),
                      ) ??
                      controller.gender;
                },
              ),
              EditProfileValueButton(
                title: AppStrings.dateOfBirth,
                value: controller.date,
                onTap: () async {
                  controller.date = await Get.bottomSheet(
                        EditProfileFiledSheet(
                          label: AppStrings.editYourBirthDate,
                          hint: AppStrings.dateOfBirth,
                          value: controller.date,
                          readOnly: true,
                          withValidation: true,
                        ),
                      ) ??
                      controller.date;
                },
              ),
              EditProfileValueButton(
                title: AppStrings.country,
                valueTextSize: AppSize.s15(context),
                value: controller.country.name,
                onTap: controller.onTapCountryButton,
              ),
              EditProfileValueButton(
                title: AppStrings.bio,
                valueTextSize: AppSize.s15(context),
                value: controller.bio,
                onTap: () async {
                  controller.bio = await Get.bottomSheet(
                        EditProfileFiledSheet(
                          label: AppStrings.editYourBio,
                          hint: AppStrings.bio,
                          value: controller.bio,
                        ),
                      ) ??
                      controller.bio;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
