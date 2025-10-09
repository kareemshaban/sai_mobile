import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:shimmer/shimmer.dart';

class ReelsView extends GetView<ReelsController> {
  const ReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    return Obx(
      () => controller.loadingGetReels
          ? Container(
        color: Colors.black,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                            baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                            highlightColor: Colors.black,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.black),
                              height: 40,
                              width: 40,
                            )),
                        const Spacer(),
                        Shimmer.fromColors(
                            baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                            highlightColor: Colors.black,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black),
                              height: 10,
                              width: 30,
                            )),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Shimmer.fromColors(
                            baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                            highlightColor: Colors.black,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.black),
                              height: 10,
                              width: 30,
                            )),
                        const Spacer(),
                        Shimmer.fromColors(
                            baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                            highlightColor: Colors.black,
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(100.0),
                                  color: Colors.black),
                              height: 40,
                              width: 40,
                            )),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black),
                                  height: 150.0,
                                  width: 270,
                                )),
                          ],
                        ),
                        const SizedBox(width: 10.0,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(100.0),
                                      color: Colors.black),
                                  height: 40,
                                  width: 40,
                                )),
                            const SizedBox(height: 10.0,),
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(100.0),
                                      color: Colors.black),
                                  height: 40,
                                  width: 40,
                                )),
                            const SizedBox(height: 10.0,),
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(100.0),
                                      color: Colors.black),
                                  height: 40,
                                  width: 40,
                                )),
                            const SizedBox(height: 10.0,),
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(100.0),
                                      color: Colors.black),
                                  height: 40,
                                  width: 40,
                                )),
                            const SizedBox(height: 10.0,),
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(100.0),
                                      color: Colors.black),
                                  height: 40,
                                  width: 40,
                                )),
                            const SizedBox(height: 10.0,),
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(100.0),
                                      color: Colors.black),
                                  height: 40,
                                  width: 40,
                                )),
                            const SizedBox(height: 10.0,),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black),
                                  height: 10,
                                  width: 40,
                                )),
                            const SizedBox(height: 10.0,),
                            Shimmer.fromColors(
                                baseColor: ColorManager.lightGreyColor.withOpacity(0.2),
                                highlightColor: Colors.black,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.black),
                                  height: 10,
                                  width: 150,
                                )),
                          ],
                        )
                      ],
                    ),
                  ],
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
