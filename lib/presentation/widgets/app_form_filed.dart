import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class AppFormFiled extends StatelessWidget {
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;
  final TextInputAction action;
  final void Function(String)? onChanged;
  final bool? enabled;
  final bool isPassword;
  final TextInputType? type;
  final String? hint;
  final void Function()? onTap;
  final Color? filledColor;
  final Color? borderColor;
  final double? borderRadius;
  final Color? hintTextColor;
  final TextStyle? style;
  final bool autofocus;
  final int lineCount;
  final FocusNode? focusNode;
  final void Function(PointerDownEvent)? onTapOutside;
  final bool labelOnBorder;
  final void Function(String?)? onSubmit;
  final TextAlign? textAlign;
  final TextDirection? textDirection;

  const AppFormFiled({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.readOnly = false,
    this.action = TextInputAction.next,
    this.onChanged,
    this.enabled,
    this.isPassword = false,
    this.type,
    this.hint,
    this.onTap,
    this.filledColor,
    this.label,
    this.borderColor,
    this.borderRadius,
    this.hintTextColor,
    this.style,
    this.autofocus = false,
    this.lineCount = 1,
    this.focusNode,
    this.onTapOutside,
    this.labelOnBorder = false,
    this.onSubmit,
    this.textAlign,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null && !labelOnBorder)
          Text(
            label!,
            style: Get.textTheme.titleSmall!.copyWith(
              fontSize: AppSize.s17(context),
            ),
          ),
        TextFormField(
          style: style ??
              Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s16(context),
              ),
          textAlign: textAlign ?? TextAlign.start,
          focusNode: focusNode,
          textDirection: textDirection,
          minLines: lineCount,
          maxLines: lineCount,
          onTap: onTap,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onTapOutside:
              onTapOutside ?? (event) => FocusScope.of(context).unfocus(),
          controller: controller,
          validator: validator,
          readOnly: readOnly,
          textInputAction: action,
          onChanged: onChanged,
          enabled: enabled,
          obscureText: isPassword,
          keyboardType: type,
          autofocus: autofocus,
          onFieldSubmitted: onSubmit,
          decoration: InputDecoration(
            fillColor: filledColor,
            filled: true,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            labelText: labelOnBorder ? label : null,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: Get.textTheme.titleSmall!.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: AppSize.s14(context),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            hintText: hint,
            hintStyle: Get.textTheme.headlineSmall!.copyWith(
              fontSize: AppSize.s15(context),
              color: hintTextColor,
            ),
            enabledBorder: borderColor != null
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor!),
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  )
                : null,
            border: borderColor != null
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor!),
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  )
                : null,
            focusedBorder: borderColor != null
                ? OutlineInputBorder(
                    borderSide: BorderSide(color: borderColor!),
                    borderRadius: BorderRadius.circular(borderRadius ?? 5),
                  )
                : null,
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorManager.red),
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: ColorManager.red),
              borderRadius: BorderRadius.circular(borderRadius ?? 5),
            ),
          ),
        ),
      ],
    );
  }
}
