import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        backgroundColor: ColorManager.white,
        surfaceTintColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        insetPadding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.areYouSureYouWantToCancelThisOrder,
                textAlign: TextAlign.center,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              20.verticalSpace(),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      title: AppStrings.back,
                      onTap: () => Get.back(result: false),
                    ),
                  ),
                  10.horizontalSpace(),
                  Expanded(
                    child: AppButton(
                      title: AppStrings.cancel,
                      backgroundColor: ColorManager.appRedColor,
                      onTap: () => Get.back(result: true),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
