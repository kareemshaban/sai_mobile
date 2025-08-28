import 'package:flutter/material.dart';
import 'package:new_sai/app/extensions.dart';
import 'package:new_sai/domain/entity/stories_entity/story_entity.dart';

import 'create_story_button.dart';
import 'profile_story_item.dart';

class ProfileStoriesList extends StatelessWidget {
  final bool isMyStory;
  final List<StoryEntity> stories;
  final ScrollController? scrollController;
  const ProfileStoriesList({
    this.isMyStory = true,
    super.key,
    required this.stories,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          if (isMyStory && index == 0) {
            return const CreateStoryButton();
          }
          return ProfileStoryItem(
              model: stories[isMyStory ? index - 1 : index]);
        },
        separatorBuilder: (context, index) => 13.5.horizontalSpace(),
        itemCount: isMyStory ? stories.length + 1 : stories.length,
      ),
    );
  }
}
