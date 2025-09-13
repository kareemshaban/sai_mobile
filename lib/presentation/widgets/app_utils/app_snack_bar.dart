import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

showSnackBarWidget({
  required String message,
  Color color = ColorManager.red,
  Color textColor = ColorManager.white,
  SnackPosition? snackPosition,
  int? second,
}) {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: Text(
        message,
        style: Get.textTheme.bodyMedium!.copyWith(
          color: textColor,
          fontSize: 14,
        ),
      ),
      duration: Duration(seconds: second ?? 3),
      backgroundColor: color,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: snackPosition ?? SnackPosition.BOTTOM,
    ),
  );
}

showAppLoadingDialog({bool barrierDismissible = false}) {
  Get.dialog(
    Dialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      child: PopScope(
        canPop: barrierDismissible,
        child: const Center(
          child: AppLoader(),
        ),
      ),
    ),
    barrierDismissible: barrierDismissible,
  );
}
