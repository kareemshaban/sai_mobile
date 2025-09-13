import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';

class CreateStoryButton extends StatelessWidget {
  const CreateStoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        AppRoutes.cameraRoute,
        arguments: {
          'isStory': true,
        },
      ),
      child: Column(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              color: ColorManager.lightGreyColor.withOpacity(.8),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.add,
              color: ColorManager.primary,

            ),
          ),
          1.verticalSpace(),

        ],
      ),
    );
  }
}
