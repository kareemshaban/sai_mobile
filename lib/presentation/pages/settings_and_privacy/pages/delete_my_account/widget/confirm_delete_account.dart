import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/delete_my_account/getx/delete_my_account_controller.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class ConfirmDeleteAccount extends GetView<DeleteMyAccountController> {
  const ConfirmDeleteAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      surfaceTintColor: ColorManager.white,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.confirmDeleteAccount ,
              style: TextStyle(fontSize: 16.0 , color: Colors.black , fontWeight: FontWeight.bold ),
            ),
            20.verticalSpace(),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: AppStrings.cancel,
                    backgroundColor: ColorManager.appRedColor,
                    onTap: () => Get.back(),
                  ),
                ),
                10.horizontalSpace(),
                Expanded(
                  child: AppButton(
                    title: AppStrings.accept,
                    onTap: () => controller.deleteAccount(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
