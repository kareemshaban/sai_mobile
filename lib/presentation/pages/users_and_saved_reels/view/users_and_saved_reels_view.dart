import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/app/function.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reels_progress_bar.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reels_text_widget.dart';
import 'package:new_sai/presentation/pages/main/pages/reels/widgets/reels_tools_widget.dart';
import 'package:new_sai/presentation/pages/users_and_saved_reels/getx/users_and_saved_reels_controller.dart';
import 'package:new_sai/presentation/pages/users_and_saved_reels/widgets/delete_reels_dialog.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/resources/font_manger.dart';
import 'package:new_sai/presentation/widgets/app_back_button.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';
import 'package:new_sai/presentation/widgets/reels_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UsersAndSavedReelsView extends GetView<UsersAndSavedReelsController> {
  const UsersAndSavedReelsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.black,
        // appBar: AppBar(
        //   leading: const AppBackButton(
        //     color: ColorManager.white,
        //   ),
        //   backgroundColor: ColorManager.black,
        //   title: Text(
        //     controller.title,
        //     style: Get.textTheme.bodyLarge!.copyWith(
        //       fontSize: AppSize.s20(context),
        //     ),
        //   ),
        // ),
        body: Obx(
          () => FlutterCarousel.builder(
            itemCount: controller.reels.length,
            itemBuilder: (context, index, realIndex) {
              if (controller.reels[index].music.isNotEmpty) {
                controller.videoPlayerController = null;
              }
              return Stack(
                children: [
                  PageView.builder(
                    itemBuilder: (context, index2) {
                      StreamController<double> videoProgressController =
                          StreamController<double>();
                      final media = controller.reels[index].media[index2];
      
                      return Stack(
                        children: [
                          if (media.type == "video") ...[
                            ReelsWidget(
                              videoPath: media.url,
                              id: media.id,
                              withMusic: controller.reels[index].music.isNotEmpty,
                              getVideoController: (videoController) {
                                controller.isPlaying =
                                    videoController.value.isPlaying;
                                if (controller.reelsCurrentIndex == index) {
                                  controller.videoPlayerController =
                                      videoController;
                                  controller.videoPlayerController
                                      ?.addListener(() {
                                    double videoProgress = (controller
                                                .videoPlayerController
                                                ?.value
                                                .position
                                                .inMilliseconds ??
                                            0) /
                                        (controller.videoPlayerController?.value
                                                .duration?.inMilliseconds ??
                                            0);
                                    videoProgressController.add(videoProgress);
                                  });
                                }
                              },
                            ),
                            Obx(
                              () {
                                if (controller.showControl) {
                                  if (controller.isPlaying) {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.pause_circle_outline,
                                        size: 50,
                                        color: ColorManager.white.withOpacity(.8),
                                      ),
                                    );
                                  } else {
                                    return Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        size: 50,
                                        color: ColorManager.white.withOpacity(.8),
                                      ),
                                    );
                                  }
                                } else {
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                            Positioned.fill(
                              child: InkWell(
                                onTap: () async {
                                  if (controller.videoPlayerController?.value
                                          .isPlaying ==
                                      true) {
                                    controller.videoPlayerController?.pause();
                                    controller.showControl = true;
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    controller.showControl = false;
                                  } else {
                                    controller.videoPlayerController?.play();
                                    controller.showControl = true;
                                    await Future.delayed(
                                        const Duration(seconds: 1));
                                    controller.showControl = false;
                                  }
                                },
                                highlightColor: ColorManager.transparent,
                                child: Container(),
                              ),
                            ),
                            ReelsProgressBar(
                              videoProgressController: videoProgressController,
                              videoPlayerController:
                                  controller.videoPlayerController,
                            ),
                          ] else ...[
                            Center(
                              child: AspectRatio(
                                aspectRatio: 1080 / 1920,
                                child: AppImage(
                                  image: media.url,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: InkWell(
                                onTap: () {
                                  if (controller.audioPlayer?.playing == true) {
                                    controller.audioPlayer?.pause();
                                  } else {
                                    controller.audioPlayer?.play();
                                  }
                                },
                                highlightColor: ColorManager.transparent,
                                child: Container(),
                              ),
                            ),
                          ],
      
                        const  Positioned(
                            top: 40,
                            child:   const AppBackButton(
                              color: ColorManager.white,
                            ),
                          ),
                        ],
                      );
                    },
                    onPageChanged: controller.onChangedMediaIndex,
                    itemCount: controller.reels[index].media.length,
                  ),
                  if (controller.reels[index].media.length > 1)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Obx(
                          () => AnimatedSmoothIndicator(
                            activeIndex: controller.mediaCurrentIndex,
                            effect: ExpandingDotsEffect(
                              dotColor: ColorManager.white.withOpacity(.5),
                              activeDotColor: ColorManager.primary,
                              dotWidth: 8,
                              dotHeight: 8,
                            ),
                            count: controller.reels[index].media.length,
                          ),
                        ),
                      ),
                    ),
                  if (!isGuest())
                    Obx(
                      () => ReelsToolsWidget(
                        model: controller.reels[index],
                        onTapComment: controller.onTapReelComment,
                        onTapLike: controller.likeReel,
                        onTapSave: controller.saveReel,
                        onTapFollow: controller.sendFriendRequest,
                        onTapDelete: () => Get.dialog(DeleteReelsDialog(index)),
                        isDeleteActive: controller.reels[index].user.id ==
                            controller.profileController.appController.user.id,
                        onTapUserProfile: controller.onTapUserProfile,
                        onTapShare: controller.onTapShareReels,
                      ),
                    ),
                  ReelsTextWidget(
                    model: controller.reels[index],
                    onTapOnUserProfile: controller.onTapUserProfile,
                    onTapOnMentionUser: controller.onTapOnMentionUser,
                  ),
                ],
              );
            },
            options: FlutterCarouselOptions(
              aspectRatio: 0.5625,
              controller: controller.reelsController,
              physics: const BouncingScrollPhysics(),
              autoPlay: false,
              height: 1.h(context),
              viewportFraction: 1,
              allowImplicitScrolling: true,
              scrollDirection: Axis.vertical,
              onPageChanged: (index, reason) {
                controller.onPageChanged(index);
              },
              showIndicator: false,
            ),
          ),
        ),
      ),
    );
  }
}
