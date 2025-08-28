import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/unique_personal_id/getx/unique_personal_id_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class BuySettingsProductDialog extends GetView<UniquePersonalIdController> {
  final int productId;
  final num goldValue;
  const BuySettingsProductDialog({
    required this.goldValue,
    required this.productId,
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
              AppStrings.areYouSureToBuyThisProductFor(
                goldValue.formatCurrencyWithoutSymbol,
              ),
              style: Get.textTheme.titleLarge!,
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
                    title: AppStrings.buy,
                    onTap: () => controller.buyProduct(productId),
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
