import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/dynamic_link_handler.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/story_pages/story_view/getx/story_view_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/language_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';
import 'package:new_sai/presentation/widgets/share_bottom_sheet.dart';

class StoryViewFooterWidget extends GetView<StoryViewController> {
  const StoryViewFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: context.locale.languageCode == arabic
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Obx(
                    () => AppFormFiled(
                      controller: controller.commentController,
                      focusNode: controller.focusNode,
                      filledColor: ColorManager.black.withOpacity(.4),
                      hint: AppStrings.writeAReply,
                      style: Get.textTheme.bodyLarge!.copyWith(
                        fontSize: AppSize.s16(context),
                      ),
                      hintTextColor: ColorManager.white,
                      borderRadius: 20,
                      borderColor: ColorManager.white.withOpacity(.3),
                      suffixIcon: controller.loadingComment
                          ? const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                AppLoader(
                                  color: ColorManager.white,
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: controller.commentOnStory,
                              child: const Icon(
                                Icons.send,
                                color: ColorManager.white,
                              ),
                            ),
                    ),
                  ),
                ),
                40.horizontalSpace(),
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
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
