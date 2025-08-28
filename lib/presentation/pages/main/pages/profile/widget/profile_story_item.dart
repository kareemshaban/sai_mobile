import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_sai/app/app_controller.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';
import 'package:new_sai/presentation/resources/routes_manger.dart';
import 'package:new_sai/presentation/widgets/app_image.dart';

class ProfileStoryItem extends StatelessWidget {
  final StoryEntity model;
  const ProfileStoryItem({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    bool isMyStory = model.user.id == Get.find<AppController>().user.id;
    if (model.media.isNotEmpty) {
      return Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () => Get.toNamed(
            isMyStory ? AppRoutes.myStoryRoute : AppRoutes.storyViewRoute,
            arguments: model,
          ),
          child: AppImage(
            image: model.media.first.type == "image"
                ? model.media.first.url
                : model.media.first.thump,
            height: 65,
            width: 65,
            fit: BoxFit.cover,
            isCircle: true,
          ),
        ),
      );
    }
    return const SizedBox();
  }
}
