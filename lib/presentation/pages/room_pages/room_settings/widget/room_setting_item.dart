import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class RoomSettingItem extends StatelessWidget {
  final String title;
  final String value;
  final Color? color;
  final String? roomImage;
  final bool isFileImage;
  final void Function()? onTap;

  const RoomSettingItem({
    super.key,
    required this.title,
    this.value = '',
    this.color,
    this.roomImage,
    this.isFileImage = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.only(bottom: 20),
        color: color,
        child: Row(
          children: [
            Text(
              title,
              style: Get.textTheme.titleSmall!.copyWith(
                fontSize: AppSize.s18(context),
              ),
            ),
            10.horizontalSpace(),
            if (value.isEmpty) ...[
              const Spacer(),
              if (roomImage != null)
                if (isFileImage)
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(
                          File(roomImage!),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                else
                  AppImage(
                    image: roomImage!,
                    width: 45,
                    height: 45,
                    radius: 8,
                    fit: BoxFit.cover,
                  ),
            ] else
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  value,
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Get.textTheme.headlineSmall!.copyWith(
                    fontSize: AppSize.s16(context),
                  ),
                ),
              ),
            14.horizontalSpace(),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorManager.iconGreyColor,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
