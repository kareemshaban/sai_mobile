import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/room_pages/room_settings/getx/room_settings_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';

class RoomImageBottomSheet extends StatefulWidget {
  const RoomImageBottomSheet({super.key});

  @override
  State<RoomImageBottomSheet> createState() => _RoomImageBottomSheetState();
}

class _RoomImageBottomSheetState extends State<RoomImageBottomSheet> {
  String image = '';

  pickRoomImage() async {
    image = await pickImage() ?? '';
    setState(() {});
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            AppStrings.changeRoomImage,
            style: Get.textTheme.titleLarge!.copyWith(
              fontSize: AppSize.s20(context),
            ),
          ),
          20.verticalSpace(),
          InkWell(
            onTap: pickRoomImage,
            child: Container(
              width: 115,
              height: 115,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ColorManager.lightGreyColor.withOpacity(.4),
                image: image.isNotEmpty
                    ? DecorationImage(
                        image: FileImage(File(image)),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: image.isNotEmpty
                  ? null
                  : Image.asset(
                      ImageAssets.camera,
                    ),
            ),
          ),
          20.verticalSpace(),
          AppButton(
            title: AppStrings.save,
            width: 1.w(context),
            onTap: () {
              Get.back();
              Get.find<RoomSettingsController>().imagePath = image;
            },
          )
        ],
      ),
    );
  }
}
