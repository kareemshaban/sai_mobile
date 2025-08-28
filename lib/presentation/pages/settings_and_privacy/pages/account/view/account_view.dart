import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/account/getx/account_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/widget/setting_item.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.account),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          children: [
            Container(
              width: 1.w(context),
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              child: Column(
                children: [
                  SettingItem(
                    title: AppStrings.accountInformation,
                    onTap: () => Get.toNamed(AppRoutes.accountInformationRoute),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    title: AppStrings.password,
                    onTap: () => Get.toNamed(AppRoutes.changePasswordRoute),
                  ),
                  19.verticalSpace(),
                  SettingItem(
                    title: AppStrings.deleteMyAccount,
                    onTap: () => Get.toNamed(AppRoutes.deleteMyAccountRoute),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
