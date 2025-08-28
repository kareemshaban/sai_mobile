import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class GiftNotification extends StatefulWidget {
  final String userName;
  final void Function()? onDelete;
  const GiftNotification({super.key, required this.userName, this.onDelete});

  @override
  State<GiftNotification> createState() => _GiftNotificationState();
}

class _GiftNotificationState extends State<GiftNotification> {
  @override
  void initState() {
    initTimer();
    super.initState();
  }

  initTimer() async {
    await Future.delayed(const Duration(seconds: 5));
    widget.onDelete!();
  }

  @override
  Widget build(BuildContext context) {
    if (context.locale == arabicLocale) {
      return SlideInRight(
        duration: const Duration(milliseconds: 300),
        child: giftNotification(context),
      );
    }
    return SlideInLeft(
      duration: const Duration(milliseconds: 300),
      child: giftNotification(context),
    );
  }

  Widget giftNotification(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: .75.w(context)),
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
          decoration: BoxDecoration(
            gradient: ColorManager.gradientScaffoldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "${widget.userName}"
            " ${AppStrings.send2}"
            " ${AppStrings.gift}",
            style: Get.textTheme.bodyLarge!.copyWith(
              fontSize: AppSize.s16(context),
            ),
          ),
        ),
      ],
    );
  }
}
