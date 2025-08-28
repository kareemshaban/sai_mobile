import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:pinput/pinput.dart';

class SetRoomLockDialog extends GetView<RoomController> {
  const SetRoomLockDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final pinTheme = PinTheme(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorManager.scaffoldBackground,
        border: Border.all(color: ColorManager.borderColor),
      ),
      textStyle: Get.textTheme.titleMedium!.copyWith(
        fontSize: AppSize.s16(context),
      ),
    );
    return Dialog(
      backgroundColor: ColorManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      surfaceTintColor: ColorManager.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.lockRoomFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                controller.room.lockCode.isEmpty
                    ? AppStrings.setANewLockForYourRoom
                    : AppStrings.doYouWantToRemoveTheRoomLock,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              20.verticalSpace(),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 4,
                  controller: controller.lockRoomController,
                  defaultPinTheme: pinTheme,
                  focusedPinTheme: pinTheme,
                  followingPinTheme: pinTheme,
                  submittedPinTheme: pinTheme,
                  keyboardType: TextInputType.number,
                  readOnly: controller.room.lockCode.isNotEmpty,
                  errorBuilder: (errorText, pin) {
                    return Directionality(
                      textDirection: context.locale == arabicLocale
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          errorText!,
                          style: Get.textTheme.titleMedium!.copyWith(
                            fontSize: AppSize.s13(context),
                            color: ColorManager.red,
                          ),
                        ),
                      ),
                    );
                  },
                  errorPinTheme: pinTheme.copyBorderWith(
                      border: Border.all(color: ColorManager.red)),
                  validator: AppValidation.validateRoomLock,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                ),
              ),
              20.verticalSpace(),
              Row(
                children: [
                  if (controller.room.lockCode.isEmpty) ...[
                    Expanded(
                      child: AppButton(
                        height: 40,
                        title: AppStrings.back,
                        backgroundColor: ColorManager.scaffoldBackground,
                        textStyle: Get.textTheme.titleMedium!.copyWith(
                          fontSize: AppSize.s16(context),
                        ),
                        onTap: () => Get.back(),
                      ),
                    ),
                    10.horizontalSpace(),
                    Expanded(
                      child: Obx(
                        () => controller.loadingLockRoom
                            ? const Center(child: AppLoader())
                            : AppButton(
                                height: 40,
                                title: AppStrings.save,
                                textSize: AppSize.s16(context),
                                onTap: () {
                                  controller.lockRoom();
                                },
                              ),
                      ),
                    ),
                  ] else
                    Expanded(
                      child: Obx(
                        () => controller.loadingLockRoom
                            ? const Center(child: AppLoader())
                            : AppButton(
                                height: 40,
                                title: AppStrings.delete,
                                backgroundColor: ColorManager.red,
                                textSize: AppSize.s16(context),
                                onTap: () {
                                  controller.unlockRoom();
                                },
                              ),
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
