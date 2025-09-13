import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/getx/settings_and_privacy_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/widget/confirm_logout_dialog.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/widget/setting_item.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';

class SettingsAndPrivacyView extends GetView<SettingsAndPrivacyController> {
  const SettingsAndPrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.settingsAndPrivacy),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppStrings.account,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
            ),
            
            10.verticalSpace(),
            Container(
              width: 1.w(context),
              color: ColorManager.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Column(
                children: [
                  SettingItem(
                    icon: IconsAssets.user,
                    title: AppStrings.account,
                    onTap: () => Get.toNamed(AppRoutes.accountRoute),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    icon: IconsAssets.lock,
                    title: AppStrings.privacy,
                    onTap: () => Get.toNamed(AppRoutes.privacyRoute),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    icon: IconsAssets.shoppingCart,
                    title: AppStrings.shoppingOrders,
                    withColor: false,
                    onTap: () => Get.toNamed(AppRoutes.ordersRoute),
                  ),
                ],
              ),
            ),
            10.verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppStrings.supportAndAboutTheApp,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
            ),
            10.verticalSpace(),
            Container(
              width: 1.w(context),
              color: ColorManager.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Column(
                children: [
                  SettingItem(
                    icon: IconsAssets.language,
                    title: AppStrings.language,
                    onTap: () => Get.toNamed(AppRoutes.languageRoute),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    icon: IconsAssets.flag,
                    title: AppStrings.reportAProblem,
                    onTap: () => Get.toNamed(AppRoutes.reportAProblemRoute),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    icon: IconsAssets.question,
                    title: AppStrings.aboutUs,
                    onTap: () => Get.toNamed(
                      AppRoutes.termsPrivacyRoute,
                      arguments: 1,
                    ),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    icon: IconsAssets.infoSquare,
                    title: AppStrings.privacyPolicy,
                    onTap: () => Get.toNamed(
                      AppRoutes.termsPrivacyRoute,
                      arguments: 2,
                    ),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    icon: IconsAssets.terms,
                    title: AppStrings.termsOfUse,
                    onTap: () => Get.toNamed(
                      AppRoutes.termsPrivacyRoute,
                      arguments: 3,
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                AppStrings.logout,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s15(context),
                ),
              ),
            ),
            10.verticalSpace(),
            Container(
              width: 1.w(context),
              color: ColorManager.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: SettingItem(
                icon: IconsAssets.logout,
                title: AppStrings.logout,
                color: ColorManager.red,
                weight: FontWeight.bold ,
                onTap: () => {
                  Get.dialog(
                      ConfirmLogoutDialog()
                  )
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
