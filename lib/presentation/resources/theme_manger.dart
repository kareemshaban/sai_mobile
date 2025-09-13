import 'package:flutter/material.dart';

import 'color_manger.dart';
import 'font_manger.dart';
import 'styles_manger.dart';

ThemeData getApplicationTheme(BuildContext context) => ThemeData(
      useMaterial3: true,
      splashColor: ColorManager.transparent,
      fontFamily: FontConstants.interFontFamily,
      scaffoldBackgroundColor: ColorManager.scaffoldBackground,
      textTheme: TextTheme(
        bodyLarge: getBoldStyle(
            color: ColorManager.white, fontSize: AppSize.s20(context)),
        bodyMedium: getMediumStyle(
            color: ColorManager.white, fontSize: AppSize.s16(context)),
        bodySmall: getRegularStyle(
            color: ColorManager.white, fontSize: AppSize.s12(context)),
        displayLarge: getBoldStyle(
            color: ColorManager.primary, fontSize: AppSize.s20(context)),
        displayMedium: getMediumStyle(
            color: ColorManager.primary, fontSize: AppSize.s16(context)),
        displaySmall: getRegularStyle(
            color: ColorManager.primary, fontSize: AppSize.s12(context)),
        titleLarge: getBoldStyle(
            color: ColorManager.black, fontSize: AppSize.s20(context)),
        titleMedium: getMediumStyle(
            color: ColorManager.black, fontSize: AppSize.s16(context)),
        titleSmall: getRegularStyle(
            color: ColorManager.black, fontSize: AppSize.s16(context)),
        headlineLarge: getBoldStyle(
            color: ColorManager.textGrey, fontSize: AppSize.s20(context)),
        headlineMedium: getMediumStyle(
            color: ColorManager.textGrey, fontSize: AppSize.s16(context)),
        headlineSmall: getRegularStyle(
            color: ColorManager.textGrey, fontSize: AppSize.s12(context)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: ColorManager.black.withOpacity(.4), width: .5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: ColorManager.black.withOpacity(.4), width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: ColorManager.black.withOpacity(.4), width: .5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: ColorManager.red, width: 1),
        ),
        filled: true,
        fillColor: ColorManager.white,
        errorStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: ColorManager.red,
            ),
        hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
              fontSize: AppSize.s16(context),
              color: ColorManager.black.withOpacity(0.5),
            ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorManager.primary,
        selectionColor: ColorManager.primary.withOpacity(0.5),
        selectionHandleColor: ColorManager.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ColorManager.scaffoldBackground,
        scrolledUnderElevation: 0,
        titleSpacing: 10,
        elevation: 0,
        centerTitle: true,
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: ColorManager.white,
        surfaceTintColor: ColorManager.white,
        dayOverlayColor: WidgetStateProperty.all(ColorManager.white),
        headerHelpStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: AppSize.s16(context),
            ),
        dayStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: AppSize.s16(context),
            ),
        weekdayStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: AppSize.s16(context),
            ),
        yearStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: AppSize.s16(context),
            ),
        cancelButtonStyle: ButtonStyle(
            textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: AppSize.s18(context),
              ),
        )),
        confirmButtonStyle: ButtonStyle(
            textStyle: WidgetStateProperty.all(
          Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: AppSize.s18(context),
              ),
        )),
      ),
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColorManager.primary,
        onPrimary: ColorManager.white,
        secondary: ColorManager.primary,
        onSecondary: ColorManager.primary,
        error: ColorManager.red,
        onError: ColorManager.red,
        surface: ColorManager.white,
        onSurface: ColorManager.black,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorManager.transparent,
        surfaceTintColor: ColorManager.transparent,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorManager.white,
        selectedLabelStyle: getRegularStyle(
          color: ColorManager.primary,
          fontSize: AppSize.s15(context),
        ),
        unselectedLabelStyle: getRegularStyle(
          color: ColorManager.black,
          fontSize: AppSize.s15(context),
        ),
        selectedItemColor: ColorManager.primary,
        unselectedItemColor: ColorManager.black,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      dividerTheme: const DividerThemeData(color: ColorManager.dividerColor),
      tabBarTheme: const TabBarThemeData(
        labelPadding: EdgeInsets.zero,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: ColorManager.transparent,
      ),
    );

List<BoxShadow> getBoxShadow({
  double? x,
  double? y,
  double? opacity,
  double? blurRadius,
  Color? color,
}) =>
    [
      BoxShadow(
        color: color ?? ColorManager.black.withOpacity(opacity ?? .2),
        offset: Offset(x ?? 0, y ?? 4),
        blurRadius: blurRadius ?? 4,
      ),
    ];
