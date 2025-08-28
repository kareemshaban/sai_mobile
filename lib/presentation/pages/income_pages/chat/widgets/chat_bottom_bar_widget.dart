import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/income_pages/chat/getx/chat_controller.dart';
import 'package:new_sai/presentation/resources/assets_manger.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_form_filed.dart';
import 'package:new_sai/presentation/widgets/app_icon.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class ChatBottomBarWidget extends GetView<ChatController> {
  const ChatBottomBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: Platform.isIOS,
      minimum: Platform.isIOS ? const EdgeInsets.all(20) : EdgeInsets.zero,
      child: Obx(
        () => controller.loadingMessages
            ? const SizedBox()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        AnimatedCrossFade(
                          firstChild: InkWell(
                            onTap: controller.onTapRecord,
                            child: const AppIcon(
                              icon: IconsAssets.mic,
                              width: 25,
                              height: 25,
                              color: ColorManager.primary,
                            ),
                          ),
                          secondChild: controller.loadingSendMessage
                              ? Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    width: 30,
                                    height: 30,
                                    child: const AppLoader(),
                                  ),
                                )
                              : InkWell(
                                  onTap: controller.sendMessage,
                                  child: const AppIcon(
                                    icon: IconsAssets.sendButton,
                                    width: 25,
                                    height: 25,
                                    color: ColorManager.primary,
                                  ),
                                ),
                          crossFadeState: controller.isFiledNotEmpty ||
                                  controller.image.isNotEmpty ||
                                  controller.file.isNotEmpty ||
                                  controller.isRecord ||
                                  controller.loadingSendMessage
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          duration: const Duration(milliseconds: 300),
                        ),
                        7.horizontalSpace(),
                        if (!controller.isRecord) ...[
                          Expanded(
                            child: controller.file.isNotEmpty
                                ? Container(
                                    margin: const EdgeInsetsDirectional.only(
                                      start: 10,
                                    ),
                                    width: 1.w(context),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: ColorManager.primary,
                                    ),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: ColorManager.white
                                                .withOpacity(.2),
                                          ),
                                          child: const AppIcon(
                                            icon: IconsAssets.file,
                                            color: ColorManager.white,
                                          ),
                                        ),
                                        10.horizontalSpace(),
                                        Flexible(
                                          fit: FlexFit.tight,
                                          child: Text(
                                            controller.file.split("/").last,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Get.textTheme.bodyMedium!
                                                .copyWith(
                                              fontSize: AppSize.s16(context),
                                            ),
                                          ),
                                        ),
                                        10.horizontalSpace(),
                                        InkWell(
                                          onTap: controller.clearFile,
                                          child: Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: ColorManager.white
                                                  .withOpacity(.2),
                                            ),
                                            child: const Icon(
                                              Icons.close,
                                              color: ColorManager.appRedColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : AppFormFiled(
                                    controller: controller.messageController,
                                    borderColor: ColorManager.transparent,
                                    borderRadius: 20,
                                    hint: "${AppStrings.sendMessage} ....",
                                    hintTextColor:
                                        ColorManager.black.withOpacity(.7),
                                  ),
                          ),
                          13.horizontalSpace(),
                          if (!controller.isRecord)
                            if (controller.file.isEmpty)
                              if (controller.image.isNotEmpty) ...[
                                Stack(
                                  alignment: AlignmentDirectional.topEnd,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(controller.image),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: controller.clearImage,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          color: ColorManager.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          color: ColorManager.appRedColor,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ] else ...[
                                InkWell(
                                  onTap: controller.pickFile,
                                  child: const AppIcon(
                                    icon: IconsAssets.attachment,
                                    width: 25,
                                    height: 25,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                12.horizontalSpace(),
                                InkWell(
                                  onTap: controller.pickMessageImage,
                                  child: const AppIcon(
                                    icon: IconsAssets.cameraOutline,
                                    width: 25,
                                    height: 25,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                        ] else ...[
                          10.horizontalSpace(),
                          Text(
                            durationText(controller.timerDuration),
                            style: Get.textTheme.displayLarge!.copyWith(
                              fontSize: AppSize.s16(context),
                              color: ColorManager.appRedColor,
                            ),
                          ),
                          10.horizontalSpace(),
                          Flexible(
                            fit: FlexFit.tight,
                            child: Lottie.asset(
                              LottieAssets.wave,
                              height: 30,
                              fit: BoxFit.fill,
                            ),
                          ),
                          10.horizontalSpace(),
                          InkWell(
                            onTap: controller.onTapCancelRecord,
                            child: Text(
                              AppStrings.cancel,
                              style: Get.textTheme.titleLarge!.copyWith(
                                fontSize: AppSize.s20(context),
                                color: ColorManager.appRedColor,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
