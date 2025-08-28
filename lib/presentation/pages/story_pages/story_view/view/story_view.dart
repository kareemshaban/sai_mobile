import 'package:flutter/material.dart';
import 'package:flutter_story_presenter/flutter_story_presenter.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/presentation/pages/story_pages/story_view/getx/story_view_controller.dart';
import 'package:new_sai/presentation/pages/story_pages/story_view/widget/story_view_footer_widget.dart';
import 'package:new_sai/presentation/pages/story_pages/widgets/story_error_widget.dart';
import 'package:new_sai/presentation/pages/story_pages/widgets/story_header_widget.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_loader.dart';

class StoryView extends GetView<StoryViewController> {
  const StoryView({super.key});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.viewInsetsOf(context).bottom == 0) {
      controller.focusNode.unfocus();
    }

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          backgroundColor: ColorManager.black,
          body: Stack(
            children: [
              SizedBox(
                height: .85.h(context),
                child: FlutterStoryPresenter(
                  flutterStoryController: controller.storyController,
                  restartOnCompleted: false,
                  onCompleted: () async {
                    Get.back();
                  },
                  headerWidget: StoryHeaderWidget(
                    user: controller.story.user,
                    isMyStory: controller.isMe(),
                  ),
                  storyViewIndicatorConfig: StoryViewIndicatorConfig(
                    backgroundCompletedColor: ColorManager.white,
                    activeColor: ColorManager.white,
                    backgroundDisabledColor: ColorManager.white.withOpacity(.1),
                  ),
                  onStoryChanged: controller.onChangedStoryIndex,
                  items: List.generate(
                    controller.story.media.length,
                    (index) {
                      final item = controller.story.media[index];
                      if (item.type == 'image') {
                        return StoryItem(
                          url: item.url,
                          storyItemType: StoryItemType.image,
                          duration: const Duration(seconds: 10),
                          errorWidget: const StoryErrorWidget(),
                          storyItemSource: StoryItemSource.network,
                          imageConfig: StoryViewImageConfig(
                            progressIndicatorBuilder: (p0, p1, p2) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: ColorManager.white,
                                  value: p2.progress,
                                ),
                              );
                            },
                            fit: BoxFit.contain,
                            height: .5.h(context),
                            width: .8.w(context),
                          ),
                        );
                      } else {
                        return StoryItem(
                          url: item.url,
                          storyItemType: StoryItemType.video,
                          storyItemSource: StoryItemSource.network,
                          // isMuteByDefault: controller.story.music.isNotEmpty,
                          errorWidget: const StoryErrorWidget(),
                          duration: const Duration(seconds: 30),
                          videoConfig: const StoryViewVideoConfig(
                            cacheVideo: true,
                            fit: BoxFit.contain,
                            useVideoAspectRatio: true,
                            loadingWidget: Center(
                              child: AppLoader(
                                color: ColorManager.white,
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: StoryViewFooterWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
