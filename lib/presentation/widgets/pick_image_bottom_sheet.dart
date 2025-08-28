import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';

class PickImageBottomSheet extends StatelessWidget {
  final void Function(ImageSource source)? onTapCamera;
  final void Function(ImageSource source)? onTapGallery;
  const PickImageBottomSheet({
    super.key,
    this.onTapCamera,
    this.onTapGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.w(context),
      padding: const EdgeInsets.all(20),
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
          Text(
            AppStrings.pickImageFrom,
            style: Get.textTheme.titleLarge!.copyWith(
              fontSize: AppSize.s20(context),
            ),
          ),
          20.verticalSpace(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  onTapCamera!(ImageSource.camera);
                },
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const AppIcon(
                        icon: IconsAssets.camera,
                        color: ColorManager.primary,
                      ),
                    ),
                    10.verticalSpace(),
                    Text(
                      AppStrings.camera,
                      style: Get.textTheme.titleLarge!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  onTapCamera!(ImageSource.gallery);
                },
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorManager.primary.withOpacity(.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const AppIcon(
                        icon: IconsAssets.gallery,
                        color: ColorManager.primary,
                      ),
                    ),
                    10.verticalSpace(),
                    Text(
                      AppStrings.gallery,
                      style: Get.textTheme.titleLarge!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
