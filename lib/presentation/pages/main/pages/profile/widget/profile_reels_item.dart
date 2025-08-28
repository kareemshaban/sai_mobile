import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ProfileReelsItem extends StatelessWidget {
  final ReelsEntity model;
  final void Function()? onTap;
  const ProfileReelsItem({
    super.key,
    required this.model,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned.fill(
            child: model.media.isNotEmpty
                ? AppImage(
                    image: model.media.first.type == "video"
                        ? model.media.first.thump
                        : model.media.first.url,
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: ColorManager.black.withOpacity(.15),
                    child: const Center(
                      child: Icon(
                        Icons.info_outline,
                        color: ColorManager.white,
                      ),
                    ),
                  ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppIcon(
                    icon: IconsAssets.playButtonStroke,
                    width: 13,
                    height: 13,
                    color: ColorManager.white,
                  ),
                  2.horizontalSpace(),
                  Text(
                    model.countViews.toString(),
                    style: Get.textTheme.bodySmall!.copyWith(
                      fontSize: AppSize.s12(context),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
