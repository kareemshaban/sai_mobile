import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';

class TopFilterWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool isActive;
  const TopFilterWidget({
    super.key,
    required this.title,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: isActive ? ColorManager.primary : null,
          ),
          child: Text(
            title,
            style: Get.textTheme.bodyLarge!.copyWith(
              fontSize: AppSize.s14(context),
              color: isActive ? null : ColorManager.black.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}
