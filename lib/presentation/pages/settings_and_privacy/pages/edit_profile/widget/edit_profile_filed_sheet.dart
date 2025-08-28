import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_validation.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';

class EditProfileFiledSheet extends StatefulWidget {
  final String label;
  final String hint;
  final String value;
  final bool withValidation;
  final bool readOnly;
  const EditProfileFiledSheet({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    this.withValidation = false,
    this.readOnly = false,
  });

  @override
  State<EditProfileFiledSheet> createState() => _EditProfileFiledSheetState();
}

class _EditProfileFiledSheetState extends State<EditProfileFiledSheet> {
  final filedController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    filedController.text = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: ColorManager.scaffoldBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: Get.textTheme.titleLarge!.copyWith(
                fontSize: AppSize.s20(context),
              ),
            ),
            20.verticalSpace(),
            AppFormFiled(
              hint: widget.hint,
              controller: filedController,
              readOnly: widget.readOnly,
              onTap: () {
                if (widget.readOnly) {
                  onTapDate(context, controller: filedController);
                }
              },
              validator:
                  widget.withValidation ? AppValidation.validateEmpty : null,
            ),
            20.verticalSpace(),
            AppButton(
              title: AppStrings.save,
              onTap: () {
                if (formKey.currentState!.validate()) {
                  Get.back(result: filedController.text);
                }
              },
              width: 1.w(context),
            )
          ],
        ),
      ),
    );
  }
}
