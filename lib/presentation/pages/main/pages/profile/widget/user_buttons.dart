import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/share_bottom_sheet.dart';

class UserButtons extends StatelessWidget {
  const UserButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppButton(
          radius: 10,
          title: "",
          onTap: () => Get.toNamed(AppRoutes.editProfileRoute),
          backgroundColor: ColorManager.lightGreyColor,
          widget:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(AppStrings.editProfile, style: TextStyle(fontSize: AppSize.s11(context),
                  fontWeight: FontWeight.bold , color: Colors.black),),
              SizedBox(width: 5.0,),
              Icon(Icons.edit , color: Colors.black,),
            ],
          ),
        ),
        12.horizontalSpace(),
        AppButton(
          title: "",
          radius: 10,

          backgroundColor: ColorManager.lightGreyColor,
          widget:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(AppStrings.shareProfile, style: TextStyle(fontSize: AppSize.s11(context),
          fontWeight: FontWeight.bold , color: Colors.black),),
          SizedBox(width: 5.0,),
          Icon(Icons.share , color: Colors.black,),
          ],
          ),
          onTap: () {
            final link =
                "Checkout this profile in SAI app ${DynamicLinkHandler.createProfileLink(id: Get.find<AppController>().user.id)}";
            Get.bottomSheet(ShareBottomSheet(shareLink: link));
          },
        ),
      ],
    );
  }
}
