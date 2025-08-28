import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class PrivacyBottomSheet extends StatelessWidget {
  final String title;
  final bool allValue;
  final bool friendsValue;
  final bool noneValue;
  final bool withNoneValue;
  final void Function(bool?)? onChangedAll;
  final void Function(bool?)? onChangedFriends;
  final void Function(bool?)? onChangedNone;
  const PrivacyBottomSheet({
    super.key,
    required this.title,
    this.onChangedAll,
    this.onChangedFriends,
    this.onChangedNone,
    this.allValue = false,
    this.friendsValue = false,
    this.noneValue = false,
    this.withNoneValue = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      decoration: const BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 1.w(context),
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: ColorManager.privacyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: Get.textTheme.titleMedium!.copyWith(
                fontSize: AppSize.s22(context),
              ),
            ),
          ),
          20.verticalSpace(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CheckboxListTile(
              value: allValue,
              onChanged: onChangedAll,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppStrings.all,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CheckboxListTile(
              value: friendsValue,
              onChanged: onChangedFriends,
              checkboxShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppStrings.friends,
                style: Get.textTheme.titleSmall!.copyWith(
                  fontSize: AppSize.s20(context),
                ),
              ),
            ),
          ),
          if (withNoneValue == true)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CheckboxListTile(
                value: noneValue,
                onChanged: onChangedNone,
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: EdgeInsets.zero,
                title: Text(
                  AppStrings.none,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s20(context),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
