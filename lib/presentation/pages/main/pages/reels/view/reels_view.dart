import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_permission.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/getx/reels_controller.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reels_app_bar_widget.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reels_page_view.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/resources/string_manger.dart';
import 'package:new_sai/presentation/widgets/app_button.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.loadingGetReels
          ? Container(
              width: 1.w(context),
              height: 1.h(context),
              color: ColorManager.white,
              child: const Center(
                child: AppLoader(
                  color: ColorManager.white,
                ),
              ),
            )
          : RefreshIndicator(
              key: controller.refreshKey,
              onRefresh: () => controller.getReels(isRefresh: true),
              child: controller.isError
                  ? Container(
                      width: 1.w(context),
                      height: 1.h(context),
                      color: ColorManager.black,
                      child: Center(
                        child: AppButton(
                          title: AppStrings.tryAgain,
                          onTap: controller.getReels,
                        ),
                      ),
                    )
                  : controller.reels.isEmpty
                      ? Container(
                          width: 1.w(context),
                          height: 1.h(context),
                          color: ColorManager.black,
                          child: Stack(
                            children: [
                              ReelsAppBarWidget(
                                onTapAdd: () async {
                                  controller.audioPlayer?.pause();
                                  controller.videoPlayerController?.pause();
                                  if (await AppPermission
                                          .requestCameraPermission() &&
                                      await AppPermission
                                          .requestMicPermission()) {
                                    await Get.toNamed(
                                      AppRoutes.cameraRoute,
                                      arguments: {
                                        'isStory': false,
                                      },
                                    );
                                    controller.videoPlayerController?.play();
                                    controller.audioPlayer?.play();
                                  }
                                },
                              ),
                              Center(
                                child: controller.reelsFilter != 0
                                    ? Text(
                                        AppStrings
                                            .followFriendsToWatchTheirReelsContent,
                                        style:
                                            Get.textTheme.bodyLarge!.copyWith(
                                          fontSize: AppSize.s16(context),
                                        ),
                                      )
                                    : AppButton(
                                        title: AppStrings.addReels,
                                        onTap: () async {
                                          if (await AppPermission
                                                  .requestCameraPermission() &&
                                              await AppPermission
                                                  .requestMicPermission()) {
                                            await Get.toNamed(
                                              AppRoutes.cameraRoute,
                                              arguments: {
                                                'isStory': false,
                                              },
                                            );
                                            controller.videoPlayerController
                                                ?.play();
                                          }
                                        },
                                      ),
                              ),
                            ],
                          ),
                        )
                      : const ReelsPageView(),
            ),
    );
  }
}
