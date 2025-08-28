import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class AppButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final double? textSize;
  final Color? backgroundColor;
  final TextStyle? textStyle;
  final double? radius;
  final double? elevation;
  final Widget? widget;
  const AppButton({
    super.key,
    required this.title,
    this.onTap,
    this.margin,
    this.width,
    this.height,
    this.padding,
    this.textSize,
    this.backgroundColor,
    this.textStyle,
    this.radius,
    this.elevation,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 44,
      margin: margin,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              WidgetStatePropertyAll(backgroundColor ?? ColorManager.primary),
          padding: WidgetStatePropertyAll(padding),

          shape: WidgetStatePropertyAll(

            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 30),
            ),
          ),
          elevation: WidgetStatePropertyAll(elevation ?? 3),
        ),
        onPressed: onTap,
        child: widget ??
            Text(
              title,
              style: textStyle ??
                  Get.textTheme.bodySmall!.copyWith(
                    fontSize: textSize ?? AppSize.s20(context),
                  ),
            ),
      ),
    );
  }
}
