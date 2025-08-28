import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/pages/auth/otp/getx/otp_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:pinput/pinput.dart';

class PinPutWidget extends GetView<OtpController> {
  const PinPutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        controller: controller.otpController,
        keyboardType: TextInputType.number,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        length: 4,
        defaultPinTheme: PinTheme(
          height: 55,
          width: 55,
          textStyle: Get.textTheme.titleLarge!.copyWith(
            fontSize: AppSize.s16(context),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10.5),
          decoration: const BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                width: 1,
                color: ColorManager.borderColor,
              ),
            ),
          ),
        ),
        focusedPinTheme: PinTheme(
          height: 55,
          width: 55,
          textStyle: Get.textTheme.titleLarge!.copyWith(
            fontSize: AppSize.s16(context),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10.5),
          decoration: const BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                width: 1,
                color: ColorManager.borderColor,
              ),
            ),
          ),
        ),
        onCompleted: (value) {
          controller.onSubmit();
        },
      ),
    );
  }
}
