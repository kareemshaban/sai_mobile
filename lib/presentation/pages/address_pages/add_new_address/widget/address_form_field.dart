import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class AddressFormField extends StatelessWidget {
  final String? title;
  final String? hint;
  final Widget? suffix;
  final TextInputAction action;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? type;
  final bool readOnly;
  final void Function()? onTap;
  const AddressFormField({
    super.key,
    this.title,
    this.hint,
    this.suffix,
    this.action = TextInputAction.next,
    this.controller,
    this.validator,
    this.type,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(
            title!,
            style: Get.textTheme.titleMedium!.copyWith(
              fontSize: AppSize.s16(context),
            ),
          ),
        ],
        TextFormField(
          keyboardType: type,
          readOnly: readOnly,
          onTap: onTap,
          textInputAction: action,
          controller: controller,
          validator: validator,
          style: Get.textTheme.titleMedium!.copyWith(
            fontSize: AppSize.s16(context),
          ),
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            filled: false,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGreyColor),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGreyColor),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.red),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.red),
            ),
            disabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGreyColor),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: ColorManager.lightGreyColor),
            ),
            hintText: hint,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
