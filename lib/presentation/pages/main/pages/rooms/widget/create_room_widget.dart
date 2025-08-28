import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/resources/theme_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class CreateRoomWidget extends StatelessWidget {
  const CreateRoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed(AppRoutes.createRoomRoute),
      child: Container(
        width: 1.w(context),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.white,
          boxShadow:
              getBoxShadow(color: ColorManager.lightGreyColor.withOpacity(.25)),
        ),
        child: Row(
          children: [
            const AppIcon(
              icon: IconsAssets.home,
              width: 50,
              height: 50,
            ),
            6.horizontalSpace(),
            Column(
              children: [
                Text(
                  AppStrings.createMyRoom,
                  style: Get.textTheme.titleSmall!.copyWith(
                    fontSize: AppSize.s17(context),
                  ),
                ),
                7.verticalSpace(),
                Text(
                  AppStrings.startYourJourneyAtSAI,
                  style: Get.textTheme.headlineSmall!.copyWith(
                    fontSize: AppSize.s11(context),
                  ),
                )
              ],
            ),
            const Spacer(),
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                color: ColorManager.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.add,
                size: 20,
                color: ColorManager.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
