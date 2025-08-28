import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/settings_and_privacy/pages/vip/getx/vip_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/resources/theme_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class VipBottomButton extends GetView<VipController> {
  const VipBottomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingGetPremium
          ? const SizedBox()
          : Container(
              width: 1.w(context),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
              decoration: BoxDecoration(
                color: ColorManager.white,
                boxShadow: getBoxShadow(),
              ),
              child: Row(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "${controller.premium.duration} ${AppStrings.month} - ${controller.premium.data[controller.currentIndex].activationPrice.formatCurrencyWithoutSymbol} ${AppStrings.toSubscribe}",
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSize.s16(context),
                          ),
                        ),
                        5.verticalSpace(),
                        Text(
                          "${controller.premium.data[controller.currentIndex].renewalPrice.formatCurrencyWithoutSymbol} - ${AppStrings.monthsToRenew("${controller.premium.duration}")}",
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSize.s14(context),
                            color: ColorManager.black.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  10.horizontalSpace(),
                  if (controller.premium.isExpierd == 1) ...[
                    if (controller.premium.type == "renewal" &&
                        controller.premium.categoryId ==
                            controller.premium.data[controller.currentIndex].id)
                      AppButton(
                        title: AppStrings.renewal,
                        radius: 10,
                        height: 50,
                        onTap: controller.renewPreium,
                        textStyle: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      )
                    else
                      AppButton(
                        title: AppStrings.activation,
                        radius: 10,
                        height: 50,
                        onTap: controller.activatePreium,
                        textStyle: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                  ] else ...[
                    if (controller.premium.categoryId ==
                        controller.premium.data[controller.currentIndex].id)
                      AppButton(
                        title: AppStrings.activated,
                        radius: 10,
                        height: 50,
                        textStyle: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      ),
                    if (controller.premium.categoryId == 0)
                      AppButton(
                        title: AppStrings.activation,
                        radius: 10,
                        height: 50,
                        onTap: controller.activatePreium,
                        textStyle: Get.textTheme.bodyLarge!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                      )
                  ],
                ],
              ),
            ),
    );
  }
}
