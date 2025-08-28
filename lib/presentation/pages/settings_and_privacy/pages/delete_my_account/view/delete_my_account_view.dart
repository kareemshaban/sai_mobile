import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/delete_my_account/getx/delete_my_account_controller.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class DeleteMyAccountView extends GetView<DeleteMyAccountController> {
  const DeleteMyAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 60,
        leading: const AppBackButton(),
        title: Text(AppStrings.deleteMyAccount),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppStrings.ifYouDeleteYourAccount}:",
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s17(context),
                fontWeight: FontWeightManger.semiBold,
              ),
            ),
            23.verticalSpace(),
            Text(
              AppStrings.deleteAccountText,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s13(context),
                height: 1.5,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Obx(
                  () => SizedBox(
                    width: 15,
                    height: 15,
                    child: Checkbox(
                      value: controller.confirmDelete,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      onChanged: controller.onChangeConfirmDelete,
                    ),
                  ),
                ),
                6.horizontalSpace(),
                Text(
                  AppStrings.iHaveReadAndUnderstoodWhatIHaveCompleted,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s13(context),
                  ),
                )
              ],
            ),
            36.verticalSpace(),
            Center(
              child: AppButton(
                title: AppStrings.next,
                width: .7.w(context),
                onTap: controller.deleteAccount,
              ),
            )
          ],
        ),
      ),
    );
  }
}
