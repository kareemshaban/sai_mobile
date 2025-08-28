import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class GenderBottomSheet extends StatefulWidget {
  final String value;
  const GenderBottomSheet({super.key, required this.value});

  @override
  State<GenderBottomSheet> createState() => _GenderBottomSheetState();
}

class _GenderBottomSheetState extends State<GenderBottomSheet> {
  String gender = '';

  @override
  void initState() {
    gender = widget.value;
    super.initState();
  }

  onTapGender(String value) {
    gender = value;
    setState(() {});
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.chooseYourGender,
            style: Get.textTheme.titleLarge!.copyWith(
              fontSize: AppSize.s20(context),
            ),
          ),
          20.verticalSpace(),
          Container(
            width: 1.w(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorManager.black.withOpacity(.3)),
              color: ColorManager.white,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onTapGender(AppStrings.male),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(8),
                            topStart: Radius.circular(8),
                          ),
                          color: gender == AppStrings.male
                              ? ColorManager.primary
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          AppStrings.male,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s17(context),
                            color: gender == AppStrings.male
                                ? ColorManager.white
                                : ColorManager.black.withOpacity(.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(width: 0),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onTapGender(AppStrings.female),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(8),
                            topEnd: Radius.circular(8),
                          ),
                          color: gender == AppStrings.female
                              ? ColorManager.primary
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          AppStrings.female,
                          textAlign: TextAlign.center,
                          style: Get.textTheme.titleSmall!.copyWith(
                            fontSize: AppSize.s17(context),
                            color: gender == AppStrings.female
                                ? ColorManager.white
                                : ColorManager.black.withOpacity(.4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          20.verticalSpace(),
          AppButton(
            title: AppStrings.save,
            width: 1.w(context),
            onTap: () => Get.back(result: gender),
          )
        ],
      ),
    );
  }
}
