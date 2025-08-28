
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/presentation/pages/story_pages/my_stories_comment_and_views/getx/my_stories_comment_and_views_controller.dart';
import 'package:new_sai/presentation/resources/color_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class MyStoriesSlider extends GetView<MyStoriesCommentAndViewsController> {
  const MyStoriesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: FlutterCarousel(
        items: List.generate(
          controller.story.media.length,
          (index) {
            final item = controller.story.media[index];
            return StorySliderImageItem(
              model: item,
              onTap: () {
                controller.mediaController.animateToPage(index);
              },
            );
          },
        ),
        options: FlutterCarouselOptions(
          controller: controller.mediaController,
          height: 302,
          viewportFraction: .27,
          enlargeCenterPage: true,
          enlargeFactor: .215,
          showIndicator: false,
          onPageChanged: (index, reason) {
            controller.onChangedStoryIndex(index);
          },
        ),
      ),
    );
  }
}

class StorySliderImageItem extends StatelessWidget {
  final StoryMediaEntity model;
  final void Function()? onTap;
  const StorySliderImageItem({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: model.type == "image"
          ? AppImage(
              image: model.url,
             // width: 88,
           //   height: 132,
              errorWidget: const Icon(
                Icons.info_outline,
                color: ColorManager.white,
              ),
              fit: BoxFit.cover,
            )
          : AppImage(
              image: model.thump,
              width: 88,
              height: 132,
              errorWidget: const Icon(
                Icons.info_outline,
                color: ColorManager.white,
              ),
              fit: BoxFit.cover,
            ),
    );
  }
}
