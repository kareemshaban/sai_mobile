import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/auth/otp/getx/otp_controller.dart';
import 'package:new_sai/presentation/pages/auth/otp/widget/pin_put_widget.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class OtpView extends GetView<OtpController> {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        leadingWidth: 60,
        title: Text(controller.title),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 56),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.enterThe4DigitCode,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s17(context),
              ),
            ),
            11.verticalSpace(),
            Text(
              "${AppStrings.yourCodeHasBeenSentTo} ${controller.phone}",
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s12(context),
              ),
            ),
            20.verticalSpace(),
            const PinPutWidget(),
            20.verticalSpace(),
            Obx(
              () => controller.loadingSendCode
                  ? const AppLoader()
                  : InkWell(
                      onTap: controller.duration.inSeconds > 0
                          ? null
                          : controller.onResendCode,
                      child: Text(
                        controller.duration.inSeconds > 0
                            ? durationText(controller.duration)
                            : AppStrings.resendCode,
                        style: Get.textTheme.displaySmall!.copyWith(
                          fontSize: AppSize.s17(context),
                        ),
                      ),
                    ),
            ),
            if (controller.withButton) ...[
              const Spacer(),
              AppButton(
                title: AppStrings.confirm,
                width: .7.w(context),
                onTap: () {
                  controller.onSubmit();
                },
              ),
              80.verticalSpace(),
            ],
          ],
        ),
      ),
    );
  }
}
