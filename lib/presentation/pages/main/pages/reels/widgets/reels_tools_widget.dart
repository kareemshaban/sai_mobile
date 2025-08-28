import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/reels_entity/reels_entity.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/share_bottom_sheet.dart';

class ReelsToolsWidget extends StatelessWidget {
  final ReelsEntity model;
  final void Function()? onTapComment;
  final void Function()? onTapLike;
  final void Function()? onTapSave;
  final void Function()? onTapFollow;
  final void Function()? onTapDelete;
  final void Function()? onTapUserProfile;
  final void Function() onTapShare;
  final bool isDeleteActive;
  const ReelsToolsWidget({
    super.key,
    required this.model,
    this.onTapComment,
    this.onTapLike,
    this.onTapSave,
    this.onTapFollow,
    this.onTapDelete,
    this.isDeleteActive = false,
    this.onTapUserProfile,
    required this.onTapShare,
  });

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      bottom: 0,
      end: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            SizedBox(
              width: 45,
              height: 45,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  InkWell(
                    onTap: onTapUserProfile,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        model.user.logo,
                        width: 45,
                        height: 45,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const AppImage(
                          image: Constants.userErrorWidget,
                          fit: BoxFit.cover,
                          width: 45,
                          height: 45,
                        ),
                      ),
                    ),
                  ),
                  if (!model.isFollowing &&
                      model.user.id != Get.find<AppController>().user.id)
                    PositionedDirectional(
                      bottom: -10,
                      start: 10,
                      child: InkWell(
                        onTap: onTapFollow,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorManager.primary,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: ColorManager.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            15.verticalSpace(),
            InkWell(
              onTap: onTapLike,
              child: Icon(
                Icons.favorite,
                color: model.isLike ? ColorManager.red : ColorManager.white,
                size: 40,
              ),
            ),
            1.verticalSpace(),
            Text(
              model.countLikes.toString(),
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s12(context),
              ),
            ),
            8.verticalSpace(),
            InkWell(
              onTap: onTapComment,
              child: const AppIcon(
                icon: IconsAssets.commentFill,
                width: 35,
                height: 35,
                color: ColorManager.white,
              ),
            ),
            1.verticalSpace(),
            Text(
              model.countComments.toString(),
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s12(context),
              ),
            ),
            8.verticalSpace(),
            InkWell(
              onTap: onTapSave,
              child: Icon(
                model.isSave ? Icons.bookmark : Icons.bookmark_add_outlined,
                color: Colors.white,
                size: 40,
              ),
            ),
            1.verticalSpace(),
            Text(
              model.countSaves.toString(),
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s12(context),
              ),
            ),
            8.verticalSpace(),
            InkWell(
              onTap: () {
                final link =
                    "Checkout this reel in SAI app ${DynamicLinkHandler.createReelsLink(id: model.id)}";
                Get.bottomSheet(ShareBottomSheet(shareLink: link));
                onTapShare();
              },
              child: const Icon(
                Icons.reply,
                color: Colors.white,
                size: 40,
              ),
            ),
            1.verticalSpace(),
            Text(
              model.countShare.toString(),
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s12(context),
              ),
            ),
            8.verticalSpace(),
            const Icon(
              Icons.play_circle_outline,
              color: Colors.white,
              size: 40,
            ),
            1.verticalSpace(),
            Text(
              model.countViews.toString(),
              style: Get.textTheme.bodySmall!.copyWith(
                fontSize: AppSize.s12(context),
              ),
            ),
            if (isDeleteActive) ...[
              8.verticalSpace(),
              InkWell(
                onTap: onTapDelete,
                child: const Icon(
                  Icons.delete_forever_outlined,
                  color: ColorManager.white,
                  size: 40,
                ),
              ),
            ],
            50.verticalSpace(),
          ],
        ),
      ),
    );
  }
}
