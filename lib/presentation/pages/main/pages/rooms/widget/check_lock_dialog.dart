import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/room_entity/room_entity.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:pinput/pinput.dart';
import 'package:x_overlay/x_overlay.dart';

class CheckLockDialog extends StatefulWidget {
  final RoomEntity room;
  final String lockCode;
  const CheckLockDialog({
    super.key,
    required this.room,
    required this.lockCode,
  });

  @override
  State<CheckLockDialog> createState() => _CheckLockDialogState();
}

class _CheckLockDialogState extends State<CheckLockDialog> {
  final otpController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  onSendCode() async {
    if (formKey.currentState!.validate()) {
      if (otpController.text == widget.lockCode) {
        if (Get.isRegistered<RoomController>()) {
          final roomController = Get.find<RoomController>();
          if (AppRoutes.overlayController.pageStateNotifier.value ==
              XOverlayPageState.overlaying) {
            AppRoutes.overlayController.hide();
            await roomController.closeAndDisposeRoom();
          }
          roomController.initController(
            widget.room.id.toString(),
            data: {
              "roomName": widget.room.roomName,
              "referenceId": widget.room.roomReferenceId,
              "backgroundTheme": widget.room.backgroundTheme,
              "roomImage": widget.room.roomImage,
            },
          );
        }
        Get.toNamed(AppRoutes.roomRoute, arguments: {
          "id": widget.room.id.toString(),
          "data": {
            "roomName": widget.room.roomName,
            "referenceId": widget.room.roomReferenceId,
            "backgroundTheme": widget.room.backgroundTheme,
            "roomImage": widget.room.roomImage,
          }
        });
      } else {
        showSnackBarWidget(message: AppStrings.lockCodeDoesNotMatch);
      }
    }
  }

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
      surfaceTintColor: ColorManager.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: 1.w(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: ColorManager.white,
        ),
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.pleaseEnterRoomLockCode,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s22(context),
                ),
              ),
              20.verticalSpace(),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 4,
                  controller: otpController,
                  defaultPinTheme: pinTheme,
                  focusedPinTheme: pinTheme,
                  followingPinTheme: pinTheme,
                  submittedPinTheme: pinTheme,
                  keyboardType: TextInputType.number,
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
                  onCompleted: (value) {
                    onSendCode();
                  },
                ),
              ),
              20.verticalSpace(),
              AppButton(
                title: AppStrings.send,
                width: 1.w(context),
                onTap: onSendCode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
