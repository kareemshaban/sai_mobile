import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_utils/app_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppDialog extends StatelessWidget {
  final String link;
  const UpdateAppDialog({super.key, required this.link});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Dialog(
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
                AppStrings.youNeedToUpdateAppBeforeContinuing,
                textAlign: TextAlign.center,
                style: Get.textTheme.titleLarge!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
              20.verticalSpace(),
              AppButton(
                title: AppStrings.update,
                width: 1.w(context),
                onTap: () async {
                  try {
                    if (!await launchUrl(
                      Uri.parse(link),
                      mode: LaunchMode.externalApplication,
                    )) {
                      showSnackBarWidget(
                        message:
                            AppStrings.cannotLuncheThisUrlForNowTryAgainLater,
                      );
                    }
                  } catch (e) {
                    showSnackBarWidget(
                      message:
                          AppStrings.cannotLuncheThisUrlForNowTryAgainLater,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
