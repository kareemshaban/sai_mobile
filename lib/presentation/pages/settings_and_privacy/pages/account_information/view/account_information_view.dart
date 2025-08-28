import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account_information/getx/account_information_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/widget/setting_item.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';

class AccountInformationView extends GetView<AccountInformationController> {
  const AccountInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: Text(AppStrings.accountInformation),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            Container(
              width: 1.w(context),
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Obx(
                () => Column(
                  children: [
                    SettingItem(
                      title: AppStrings.mobileNumber,
                      value: controller.appController.user.phone
                          .replaceRange(4, 8, "***"),
                      onTap: () =>
                          Get.toNamed(AppRoutes.changeMobileNumberRoute),
                    ),
                    19.verticalSpace(),
                    SettingItem(
                      title: AppStrings.email,
                      value: controller.appController.user.email.isNotEmpty
                          ? controller.appController.user.email
                          : AppStrings.link,
                      onTap: () => Get.toNamed(AppRoutes.changeEmailRoute),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
