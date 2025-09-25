import 'dart:io';

import 'package:detectable_text_field/detectable_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/room_pages/room/getx/room_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class RoomBottomBarWidget extends GetView<RoomController> {
  final bool isLoading;


  const RoomBottomBarWidget({this.isLoading = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: controller.enableScroll && controller.enableTag
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            secondChild: const SizedBox(),
            firstChild: Container(
              width: 1.w(context),
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 6),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    controller.users
                        .where((element) =>
                            element.userID !=
                            controller.appController.user.id.toString())
                        .toList()[index]
                        .userName,
                    style: Get.textTheme.labelLarge!,
                  ),
                  onTap: () {
                    controller.messageController.text +=
                        "@${controller.users.where((element) => element.userID != controller.appController.user.id.toString()).toList()[index].userName.replaceAll(" ", "_")}\n";
                    controller.toggleTag();
                  },
                  minVerticalPadding: 6,
                  minTileHeight: 0,
                ),
                itemCount: controller.users
                    .where((element) =>
                        element.userID !=
                        controller.appController.user.id.toString())
                    .toList()
                    .length,
              ),
            ),
          ),
          controller.enableScroll
              ? Column(
                children: [
                  Container(
                      color:  ColorManager.white,
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.viewInsetsOf(context).bottom + 7,
                          top: 7,
                          left: 7,
                          right: 7),
                      child: Row(
                        children: [
                          if (controller.messageImage.isNotEmpty)
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(controller.messageImage),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                PositionedDirectional(
                                  top: 0,
                                  end: 0,
                                  child: InkWell(
                                    onTap: controller.clearMessageImage,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: ColorManager.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        color: ColorManager.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          else
                            InkWell(
                              onTap: controller.onPickMessageImage,
                              child: const AppIcon(
                                icon: IconsAssets.gallery,
                                width: 20,
                                height: 20,
                              ),
                            ),
                          5.horizontalSpace(),
                          Expanded(
                            child: SizedBox(
                              height: 30.0,
                              child: DetectableTextField(
                                style: Get.textTheme.labelLarge!.copyWith(
                                  fontSize: AppSize.s14(context),
                                  color: Colors.black,
                                ),
                                onTap: () {
                                  controller.showEmojiPicker = false;
                                },
                                controller: controller.messageController,
                                focusNode: controller.focusNode,
                                minLines: 1,
                                maxLines: 1,
                                maxLength: 130,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.send,
                                onSubmitted: (value) {
                                  controller.sendMessage() ;
                                  controller.focusNode.requestFocus() ;
                                },
                                decoration: InputDecoration(
                                  counterText: '',
                                  fillColor:
                                      ColorManager.lightGreyColor,
                                  filled: true,
                                  border: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.transparent,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.transparent,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: ColorManager.transparent,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                  hintText: AppStrings.saySomthing,
                                  helperStyle: Get.textTheme.labelMedium!.copyWith(
                                    color: ColorManager.textGrey2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          5.horizontalSpace(),
                          InkWell(
                            onTap: controller.toggleTag,
                            child: const Icon(
                              Icons.alternate_email,
                              size: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              )
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap:
                                isLoading ? null : controller.toggleMuteAllLocally,
                            child: Icon(
                              controller.isMuteAll
                                  ? Icons.volume_off_rounded
                                  : Icons.volume_up_outlined,
                              color: ColorManager.white,
                              size: 30,
                            ),
                          ),
                          10.horizontalSpace(),
                          if (controller.isTakingSeat) ...[
                            InkWell(
                              onTap: isLoading ? null : controller.toggleMic,
                              child: Icon(
                                controller.micState
                                    ? Icons.mic_none_outlined
                                    : Icons.mic_off_outlined,
                                color: ColorManager.white,
                                size: 30,
                              ),
                            ),
                            10.horizontalSpace(),
                          ],
                          Expanded(
                            child: InkWell(
                              onTap: isLoading
                                  ? null
                                  : () {
                                      controller.enableScroll = true;
                                      controller.enableTag = false;
                                    },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: ColorManager.white.withOpacity(.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.saySomthing,
                                      style: Get.textTheme.bodySmall!.copyWith(
                                        fontSize: AppSize.s15(context),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.emoji_emotions_outlined,
                                      color: ColorManager.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          50.horizontalSpace(),
                        ],
                      ),
                    ],
                  ),
                ),
          if (!controller.enableScroll) 15.verticalSpace(),
        ],
      ),
    );
  }
}
