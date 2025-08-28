import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/story_pages/my_story/getx/my_story_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/share_bottom_sheet.dart';

class MyStoryFooterWidget extends GetView<MyStoryController> {
  const MyStoryFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == arabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Row(
                children: [
                  InkWell(
                    onTap: () async {
                      controller.storyController.pause();
                      await Get.toNamed(
                        AppRoutes.myStoriesCommentAndViewsRoute,
                        arguments: controller.story,
                      );
                      controller.storyController.play();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.white.withOpacity(.4),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.visibility,
                            color: ColorManager.white,
                            size: 12,
                          ),
                          3.horizontalSpace(),
                          if (controller.story.media.isNotEmpty)
                            Text(
                              "${controller.story.media[controller.currentIndex].countViews}",
                              style: Get.textTheme.bodySmall!.copyWith(
                                fontSize: AppSize.s10(context),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  // 14.horizontalSpace(),
                  // InkWell(
                  //   onTap: () async {
                  //     controller.storyController.pause();
                  //     await Get.toNamed(
                  //       AppRoutes.myStoriesCommentAndViewsRoute,
                  //       arguments: controller.story,
                  //     );
                  //     controller.storyController.play();
                  //   },
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //         vertical: 3, horizontal: 7),
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(20),
                  //       color: ColorManager.white.withOpacity(.4),
                  //     ),
                  //     child: Row(
                  //       children: [
                  //         const AppIcon(
                  //           icon: IconsAssets.capture,
                  //           color: ColorManager.white,
                  //           width: 12,
                  //           height: 12,
                  //         ),
                  //         3.horizontalSpace(),
                  //         Text(
                  //           "${controller.story.media[controller.currentIndex].countShare}",
                  //           style: Get.textTheme.bodySmall!.copyWith(
                  //             fontSize: AppSize.s10(context),
                  //           ),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  14.horizontalSpace(),
                  InkWell(
                    onTap: () async {
                      controller.storyController.pause();
                      await Get.toNamed(
                        AppRoutes.myStoriesCommentAndViewsRoute,
                        arguments: controller.story,
                      );
                      controller.storyController.play();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorManager.white.withOpacity(.4),
                      ),
                      child: Row(
                        children: [
                          const AppIcon(
                            icon: IconsAssets.commentFill,
                            color: ColorManager.white,
                            width: 12,
                            height: 12,
                          ),
                          3.horizontalSpace(),
                          if (controller.story.media.isNotEmpty)
                            Text(
                              "${controller.story.media[controller.currentIndex].countComments}",
                              style: Get.textTheme.bodySmall!.copyWith(
                                fontSize: AppSize.s10(context),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () async {
                      controller.storyController.pause();
                      final link =
                          "Checkout this story in SAI app ${DynamicLinkHandler.createStoryLink(id: controller.story.id)}";
                      await Get.bottomSheet(ShareBottomSheet(shareLink: link));
                      controller.storyController.play();
                    },
                    child: const Icon(
                      Icons.reply,
                      color: ColorManager.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
