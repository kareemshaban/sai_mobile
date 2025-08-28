import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:image_picker/image_picker.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/size_config.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

import 'app_permission.dart';

bool isArabic(BuildContext context) {
  return context.locale == arabicLocale;
}

bool isIpad(BuildContext context) => 1.w(context) > SizeConfig.tablet;

FlCountryCodePicker getCountryCodeStyle({bool showSearchAndDialCode = true}) {
  return FlCountryCodePicker(
    countryTextStyle: Get.textTheme.titleLarge!.copyWith(
      fontSize: 18,
    ),
    dialCodeTextStyle: Get.textTheme.titleLarge!.copyWith(
      fontSize: 16,
    ),
    favorites: ['SA', 'QA'],
    showDialCode: showSearchAndDialCode,
    showSearchBar: showSearchAndDialCode,
    searchBarTextStyle: Get.textTheme.titleMedium,
    searchBarDecoration: const InputDecoration(
      filled: true,
      fillColor: ColorManager.white,
      // suffixIcon: PrefixIconForFormFiled(icon: IconsAssets.search),
    ),
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
      child: Text(
        '${AppStrings.selectCountry} :',
        style: Get.textTheme.titleLarge,
      ),
    ),
  );
}

onTapDate(BuildContext context, {required TextEditingController controller}) {
  showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    cancelText: AppStrings.cancel,
    confirmText: AppStrings.confirm,
    locale: context.locale,
    initialDatePickerMode: DatePickerMode.day,
    initialEntryMode: DatePickerEntryMode.calendarOnly,
  ).then((value) {
    if (value != null) {
      controller.text = value.formatForApi();
    }
  });
}

Future<String?> pickImage(
    {ImageSource imageSource = ImageSource.gallery}) async {
  if (imageSource == ImageSource.camera) {
    if (await AppPermission.requestCameraPermission()) {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        return image.path;
      }
      return null;
    }
  } else {
    if (Platform.isAndroid
        ? await AppPermission.requestMediaLocationPermission()
        : await AppPermission.requestStoragePermission()) {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        return image.path;
      }
      return null;
    }
  }
  return null;
}

bool isGuest() => Get.find<AppController>().isGuest();

Future<bool> addRemoveFavorite(int params) async {
  if (!isGuest()) {
    return Get.find<AppController>().addRemoveFavorite(params);
  }
  return false;
}

String durationText(Duration duration) {
  String towDigit(int value) => value.toString().padLeft(2, "0");
  return '${duration.inHours != 0 ? '${towDigit(duration.inHours)}:' : ''}${towDigit(duration.inMinutes.remainder(60))}:${towDigit(duration.inSeconds.remainder(60))}';
}
