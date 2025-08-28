import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class GeneralNotificationMessage extends StatelessWidget {
  const GeneralNotificationMessage({
    super.key,
    required this.content,
    this.isWelcomMessage = false,
  });
  final String content;
  final bool isWelcomMessage;

  @override
  Widget build(BuildContext context) {
    if (context.locale == arabicLocale) {
      return SlideInRight(
        duration: const Duration(milliseconds: 300),
        child: generalNotification(context),
      );
    }
    return SlideInLeft(
      duration: const Duration(milliseconds: 300),
      child: generalNotification(context),
    );
  }

  Widget generalNotification(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 0.75.w(context)),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: ColorManager.white.withOpacity(.13),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isWelcomMessage)
            Text(
              AppStrings.generalNotification,
              style: Get.textTheme.bodyLarge!.copyWith(
                fontSize: AppSize.s16(context),
              ),
            ),
          Text(
            content,
            style: Get.textTheme.bodyMedium!.copyWith(
              fontSize: AppSize.s14(context),
              height: 2,
            ),
          ),
        ],
      ),
    );
  }
}
