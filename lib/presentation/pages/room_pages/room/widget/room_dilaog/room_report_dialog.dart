import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';

class RoomReportDialog extends GetView<RoomController> {
  const RoomReportDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.white,
      surfaceTintColor: ColorManager.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.reportFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.report,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              20.verticalSpace(),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  AppStrings.tellUsWhyYouAreReporting,
                  style: Get.textTheme.headlineMedium!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
              ),
              20.verticalSpace(),
              AppFormFiled(
                lineCount: 10,
                hint: AppStrings.typeSomthing,
                controller: controller.reportRoomController,
                validator: AppValidation.validateEmpty,
              ),
              20.verticalSpace(),
              AppButton(
                title: AppStrings.send,
                width: 1.w(context),
                onTap: controller.sendRoomReport,
              )
            ],
          ),
        ),
      ),
    );
  }
}
