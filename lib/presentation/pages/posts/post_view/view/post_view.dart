import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/constants.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/posts/post_view/getx/post_view_controller.dart';
import 'package:new_sai/presentation/pages/posts/post_view/widgets/post_content_widget.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:photo_manager/photo_manager.dart';

class PostView extends GetView<PostViewController> {
  const PostView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.black,
        floatingActionButton: controller.isStory
            ? InkWell(
                onTap: controller.postStory,
                child: Obx(
                  () => Container(
                    width: .7.w(context),
                    padding: const EdgeInsets.all(9),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: ColorManager.white,
                    ),
                    child: controller.isLoading
                        ? const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                child: AppLoader(),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: Image.network(
                                    controller.appController.user.profileImg,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const AppImage(
                                        image: Constants.userErrorWidget,
                                        width: 30,
                                        height: 30,
                                        isCircle: true,
                                      );
                                    },
                                    width: 30,
                                    height: 30,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              6.horizontalSpace(),
                              Text(
                                AppStrings.yourStory,
                                style: Get.textTheme.titleMedium!.copyWith(
                                  fontSize: AppSize.s20(context),
                                ),
                              )
                            ],
                          ),
                  ),
                ),
              )
            : AppButton(
                title: AppStrings.next,
                width: .7.w(context),
                onTap: () => Get.toNamed(
                  AppRoutes.postSettingsRoute,
                  arguments: {
                    "data": controller.postDataEntity,
                    "isStory": controller.isStory,
                    "music": controller.musicFilePath,
                  },
                ),
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Stack(
          children: [
            PostContentWidget(
              postDataEntity: controller.postDataEntity,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => Get.back(),
                    child: AppIcon(
                      icon: IconsAssets.arrowBack,
                      color: ColorManager.white.withOpacity(.9),
                    ),
                  ),
                  if (!controller.isStory)
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.white.withOpacity(.15),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: .52.w(context),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.music_note,
                                color: ColorManager.white.withOpacity(.6),
                              ),
                              6.horizontalSpace(),
                              Flexible(
                                child: InkWell(
                                  onTap: controller.musicFilePath.isEmpty
                                      ? controller.pickMusicFile
                                      : null,
                                  child: Text(
                                    controller.musicFilePath.isEmpty
                                        ? AppStrings.addMusic
                                        : controller.musicFilePath
                                            .split("/")
                                            .last,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w100,
                                      color: ColorManager.white.withOpacity(.7),
                                      fontSize: AppSize.s15(context),
                                    ),
                                  ),
                                ),
                              ),
                              6.horizontalSpace(),
                              if (controller.musicFilePath.isNotEmpty) ...[
                                const VerticalDivider(width: 0),
                                6.horizontalSpace(),
                                InkWell(
                                  onTap: controller.clearMusicFile,
                                  child: Icon(
                                    Icons.close,
                                    color: ColorManager.white.withOpacity(.6),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (controller.postDataEntity.mediaPathList.every(
                          (element) => element.type == AssetType.image) &&
                      controller.isStory)
                    Obx(
                      () => Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ColorManager.white.withOpacity(.15),
                        ),
                        constraints: BoxConstraints(
                          maxWidth: .52.w(context),
                        ),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.music_note,
                                color: ColorManager.white.withOpacity(.6),
                              ),
                              6.horizontalSpace(),
                              Flexible(
                                child: InkWell(
                                  onTap: controller.musicFilePath.isEmpty
                                      ? controller.pickMusicFile
                                      : null,
                                  child: Text(
                                    controller.musicFilePath.isEmpty
                                        ? AppStrings.addMusic
                                        : controller.musicFilePath
                                            .split("/")
                                            .last,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Get.textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.w100,
                                      color: ColorManager.white.withOpacity(.7),
                                      fontSize: AppSize.s15(context),
                                    ),
                                  ),
                                ),
                              ),
                              6.horizontalSpace(),
                              if (controller.musicFilePath.isNotEmpty) ...[
                                const VerticalDivider(width: 0),
                                6.horizontalSpace(),
                                InkWell(
                                  onTap: controller.clearMusicFile,
                                  child: Icon(
                                    Icons.close,
                                    color: ColorManager.white.withOpacity(.6),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  // Column(
                  //   children: [
                  //     AppIcon(
                  //       icon: IconsAssets.setting,
                  //       color: ColorManager.white.withOpacity(.7),
                  //       width: 25,
                  //       height: 25,
                  //     ),
                  //     11.verticalSpace(),
                  //     AppIcon(
                  //       icon: IconsAssets.share,
                  //       color: ColorManager.white.withOpacity(.7),
                  //       width: 20,
                  //       height: 20,
                  //     ),
                  //     11.verticalSpace(),
                  //     AppIcon(
                  //       icon: IconsAssets.aa,
                  //       color: ColorManager.white.withOpacity(.7),
                  //       width: 25,
                  //       height: 25,
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
