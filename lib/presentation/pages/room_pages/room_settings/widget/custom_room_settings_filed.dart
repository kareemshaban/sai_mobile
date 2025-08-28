import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';

class CustomRoomSettingsFiled extends StatefulWidget {
  final String title;
  final String value;
  final bool membershipFee;
  const CustomRoomSettingsFiled({
    super.key,
    required this.title,
    required this.value,
    this.membershipFee = false,
  });

  @override
  State<CustomRoomSettingsFiled> createState() =>
      _CustomRoomSettingsFiledState();
}

class _CustomRoomSettingsFiledState extends State<CustomRoomSettingsFiled> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
        color: ColorManager.white,
      ),
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            20.verticalSpace(),
            AppFormFiled(
              controller: controller,
              validator: widget.membershipFee
                  ? AppValidation.validateMembershipFee
                  : AppValidation.validateEmpty,
              type: widget.membershipFee ? TextInputType.number : null,
            ),
            20.verticalSpace(),
            if (widget.membershipFee) ...[
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  AppStrings.fees,
                  style: Get.textTheme.titleLarge!.copyWith(
                    fontSize: AppSize.s16(context),
                    color: ColorManager.black.withOpacity(.5),
                  ),
                ),
              ),
              20.verticalSpace(),
            ],
            AppButton(
              title: AppStrings.save,
              width: 1.w(context),
              onTap: () {
                if (formKey.currentState!.validate()) {
                  Get.back(result: controller.text);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
