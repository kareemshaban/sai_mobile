import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/address_pages/add_new_address/getx/add_new_address_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class DeleteAddressDialog extends GetView<AddNewAddressController> {
  const DeleteAddressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: ColorManager.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        surfaceTintColor: ColorManager.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.areYouSureYouWantToDeleteThisAddress,
                textAlign: TextAlign.center,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              30.verticalSpace(),
              Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: controller.loadingDelete
                          ? const Center(child: AppLoader())
                          : AppButton(
                              title: AppStrings.confirm,
                              backgroundColor: ColorManager.red,
                              onTap: controller.deleteAddress,
                            ),
                    ),
                  ),
                  8.horizontalSpace(),
                  Expanded(
                    child: AppButton(
                      title: AppStrings.back,
                      backgroundColor: ColorManager.primary,
                      onTap: () => Get.back(),
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
